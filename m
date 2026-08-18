Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DD3B637E;
	Tue, 18 Aug 2026 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048317; cv=none; b=gLw4cm7TvCm7nD1F4G4ewVchABVvFTOxRalRlZMkpUQuKVPAxCWZJt9/LYrvYHW5e0QkSMcOxXjUGrvmzFSpH/umx3VsLWfepqEanA9kmH2dV3yDXPIzJZuyH//GV3yXdwClN/QjXK6sWH7IJNrs/HFH1tgobXTEyXraUr0gcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048317; c=relaxed/simple;
	bh=W1YH3+8VVyvfEepL+yHDGcRwlem1OIr1djZsbDMYCGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1G5xVdMRfQLxV06qynilKWYxdD4yZy4o34fIs4LTugLlkFxo8/wsjZA0jjOcXGAsPWHTG7lvYqwfbrGUtINGkgKk6AAScDTE0Af/HzL1vONOseCBgvm2Wrv6EY6Znbi8Ww5ESI93mj9hHaYjXK4lQ9oZLh5YLlOwVcV7ZrS/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV386nPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV386nPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAF21F000E9;
	Tue, 18 Aug 2026 10:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787048316;
	bh=jwMVdHrvk7kTvruvTnXxLTgiBwjN9S2XLihzM95fzKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KV386nPWRRE08204XuIMIhxBIzXbvitBA2n8kC55lLchcC5H77jxWoNLp+CcZpgn3
	 2LTsZDmsFve1IDOETXFC31pTaUC6MfVOaYE6NuvXCjh/RzCry0bp9mbFs2YZLEwSi6
	 oDATN7X738a1cU1OBcGN4JFa2c6YxmKRqdxEVKExxYfuq7Doi24xvNkSfVcJwA4zmV
	 a35f81ArZpZD7kevePUAlhXuTZMr71l2xfygQfsQub6A0mylXm3vaZqOT0UlpqPG07
	 FpGyINUmTYl6VeIi1AW37N4uDPvYztCq/elHtEVXuU9F7lFFLOmQMxTQAQ+7ebylFv
	 jC9UKQtXv+BQw==
Message-ID: <63b6eb28-dc1b-4e51-89c0-1591ff216da5@kernel.org>
Date: Tue, 18 Aug 2026 12:18:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv
 reports on BCM4378
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260818-fix-bcm4378-ext-adv-v1-1-81a143eac194@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260818-fix-bcm4378-ext-adv-v1-1-81a143eac194@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.26 11:49, Lorenzo Stoakes (ARM) wrote:
> Commit ed2a2ef16a6b ("Bluetooth: Add quirk to ignore reserved PHY bits in
> LE Extended Adv Report") added a quirk to handle creative use of the
> reserved bits in the PHY fields for 4388 controllers in Apple silicon.
> 
> I observed the same issue with the BCM4378 Bluetooth controller (14e4:5f69,
> rev 05) on an Apple MacBook Pro (13-inch, M2, 2022):
> 
>> HCI Event: LE Meta Event (0x3e) plen 51
>        LE Extended Advertising Report (0x0d)
>          Num reports: 1
>          Entry 0
>            Event type: 0x2513
>              Props: 0x0013
>                Connectable
>                Scannable
>                Use legacy advertising PDUs
>              Data status: Complete
>              Reserved (0x2500)
>            Legacy PDU Type: Reserved (0x2513)
>            Address type: Random (0x01)
>            Address: EA:C1:82:F0:24:C6 (Static)
>            Primary PHY: Reserved
>            Secondary PHY: No packets
>            SID: no ADI field (0xff)
>            TX power: 127 dBm
>            RSSI: -57 dBm (0xc7)
>            Periodic advertising interval: 0.00 msec (0x0000)
>            Direct address type: Public (0x00)
>            Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>            Data length: 25
> 
> This results in the firmware rejecting connection attempts with
> "Unsupported Feature or Parameter Value" (0x11).
> 
> Fix the issue by using the same quirk for BCM4378 devices too.
> 
> I tested this locally and confirmed that the issue is resolved.
> 
> This was observed when attempting to connect a Kinesis Advantage 360
> keyboard to the MacBook.
> 
> Assisted-by: Claude:claude-fable-5
> Fixes: 2e7ed5f5e69b ("Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>

Kinda surprised no one ran into this so far tbh.


Best,


Sven


