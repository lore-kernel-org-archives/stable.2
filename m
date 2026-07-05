Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69336C9E5;
	Sun,  5 Jul 2026 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285128; cv=none; b=Rd9IMHmBFzqZ3+hkdf/Wv/npinzyLhy07prhh/x7Y2MItWh9qL0SX3tYeVtU1BCk9WwThnmJg/U4AVuz6HPOztdx4DPKILjeSuPh7zAWNdESX8Syg//ERfXEQG+n+evbGd7MvgPT4HsvtX71ikDqkjJbpvez1myO7GwzV8TCuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285128; c=relaxed/simple;
	bh=wxOLKp7wOdNjCDZBu3sPsyZlCtvYzCeNLqu5UUdpqGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFB57PQwKUw+8TMO0StV17iiDl/Wz+elRhWmInFvZtYouPdFjzjF2Tr6gv0cmOnw60yp73PCQoY7oawbvI2JNuAERAHUX9ggB/Zy+5qJri10D6IBXrDWGRG5qNBjIkWwYIsc1v+M5eLjjcyQOvlO5Fxdkpr6tFm1NP6oaNZuOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.225] (p5dc553f8.dip0.t-ipconnect.de [93.197.83.248])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A977E4C2C37D5D;
	Sun, 05 Jul 2026 22:58:31 +0200 (CEST)
Message-ID: <f28eea1f-80da-4def-b11f-33a531a1b595@molgen.mpg.de>
Date: Sun, 5 Jul 2026 22:58:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in
 nxp_recv_fw_req_v1()
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Neeraj Kale <neeraj.sanjaykale@nxp.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260705115650.81724-1-doruk@0sec.ai>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260705115650.81724-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Doruk,


Thank you for the patch.

Am 05.07.26 um 13:56 schrieb Doruk Tan Ozturk:
> Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
> read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset but
> left an unbounded read in the v1 handler.
> 
> nxp_recv_fw_req_v1() advances a device-driven download offset
> (fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
> bookkeeping runs even when the payload write is skipped, so the offset can
> walk past nxpdev->fw->size. When the controller then requests a header
> (len == HDR_LEN), the driver reads the 16-byte bootloader header at
> 
>    nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)
> 
> with no bound on the offset, reading past the end of the firmware image.
> A malicious or malfunctioning NXP UART controller can drive this to read
> out-of-bounds kernel memory during firmware download.
> 
> Bound the offset before the header read, and convert the payload write
> guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset is
> u32, so fw_dnld_v1_offset + len can wrap).
> 
> This was found by 0sec automated security-research tooling
> (https://0sec.ai).
> 
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>   drivers/bluetooth/btnxpuart.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 6a1cffe08d5f..88d9ebf25a8f 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1041,11 +1041,17 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
>   		 * and we need to re-send the previous header again.
>   		 */
>   		if (len == nxpdev->fw_v1_expected_len) {
> -			if (len == HDR_LEN)
> +			if (len == HDR_LEN) {
> +				if (nxpdev->fw_dnld_v1_offset >= nxpdev->fw->size ||
> +				    nxpdev->fw->size - nxpdev->fw_dnld_v1_offset < HDR_LEN) {
> +					bt_dev_err(hdev, "FW request offset out of bounds");

Would it make sense to log all the values, as I’d think, such an issue 
might be hard to reproduce and gathering the values miht be difficult?

> +					goto free_skb;
> +				}
>   				nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev->fw->data +
>   									nxpdev->fw_dnld_v1_offset);
> -			else
> +			} else {
>   				nxpdev->fw_v1_expected_len = HDR_LEN;
> +			}
>   		} else if (len == HDR_LEN) {
>   			/* FW download out of sync. Send previous chunk again */
>   			nxpdev->fw_dnld_v1_offset -= nxpdev->fw_v1_sent_bytes;
> @@ -1053,7 +1059,8 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
>   		}
>   	}
>   
> -	if (nxpdev->fw_dnld_v1_offset + len <= nxpdev->fw->size)
> +	if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
> +	    len <= nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
>   		serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
>   					nxpdev->fw_dnld_v1_offset, len);
>   	nxpdev->fw_v1_sent_bytes = len;


Kind regards,

Paul
