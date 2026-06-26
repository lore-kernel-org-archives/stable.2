Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFC3451BA;
	Fri, 26 Jun 2026 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479595; cv=none; b=tnjxGhiU5VFG64ocy83DPa0jKlCBsN/Ov0IWm/wRPiFC9MD7MAKChDhPBgYcsFq/8ThNevteUv8vUXz4LT69oT/P+TUEWrZneoRk/UteOkWw3Cu6HY6XhkBaCKL8S1ug1a0YcdXSnZ9CGxmm14lO4Y3Iuh8rhHLUhKw8RRl8OQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479595; c=relaxed/simple;
	bh=VdX9ORlKbH+cwQZyIMVJC2xaJCALc1xyp42uRsLX0cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAV++eHL/TaML6V/R6GE9WWhXY74Ps6anrrc/2g5c942FL73XdD4s/Zd2r8wYCr8dc1cIkpS0ePrRfUQOnq7XoMWyN63PAxZQK7oCDaOvumKJhVh6ozn1j2B0dNjt/3T0MJ4X4MoV5zxYygOYpHCqnCe/I7/mi+N6HACbeaoZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C58A64C2C37D45;
	Fri, 26 Jun 2026 15:12:52 +0200 (CEST)
Message-ID: <1069f872-ef51-4e41-8284-419e751c4b3f@molgen.mpg.de>
Date: Fri, 26 Jun 2026 15:12:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: net/bluetooth: iso_conn_del: extra iso_conn_put on
 iso_sock_hold failure path
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260626115312.33528-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260626115312.33528-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Wen Tao,


Thank you for your patch. Some formalities:

The prefixes are well defined, and `fix:` will make the CI fail. Also, 
it’d be great if you removed the tripple space in the summary/title, and 
made it a statement by adding a verb in imperative mood. Maybe:

Bluetooth: Fix extra iso_conn_put on iso_sock_hold failure path

Am 26.06.26 um 13:53 schrieb WenTao Liang:
> In iso_conn_del(), iso_conn_hold_unless_zero() acquires a temporary
>    reference which is correctly balanced by iso_conn_put() at line 279. When
>    iso_sock_hold() returns NULL (sk == NULL), an additional
>    iso_conn_put(conn) is called, dropping hcon's reference to conn too
>    early. The caller (e.g., hci_conn_del) will later also iso_conn_put(),
>    causing a double-free or use-after-free.

It’s uncommon to indent any lines of a paragraph. I recommend to remove 
it, and then each line also fits in 75 characters.

> Remove the extra iso_conn_put(conn) on the sk == NULL path.

Out of curiosity: Do you have a reproducer?

> Cc: stable@vger.kernel.org
> Fixes: dc26097bdb86 ("Bluetooth: ISO: Use kref to track lifetime of iso_conn")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>   net/bluetooth/iso.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 3abd8111dda8..99755671e469 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -278,10 +278,8 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
>   	iso_conn_unlock(conn);
>   	iso_conn_put(conn);
>   
> -	if (!sk) {
> -		iso_conn_put(conn);
> +	if (!sk)
>   		return;
> -	}
>   
>   	lock_sock(sk);
>   	iso_sock_clear_timer(sk);

gemini/gemini-3.1-pro-preview has two comments [1].


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/20260626115312.33528-1-vulab%40iscas.ac.cn
