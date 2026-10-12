Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B820417BE2
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826109; cv=none; b=C5VcFstOWVij1AyrYn9fYuVqkzpj4f2BQdy58aKXFaybFDSfgmvYHflr+5nbj7Gf+0cDHmlLYI3gNAfvXn33Rz9j1ZN3gGcViOrX38FkwU5fuxfsEZTu26b96qEZ3u6vF8VkSHm45KGiA2konju6BtAYh9cpwv7Pk357B0+wMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826109; c=relaxed/simple;
	bh=AXdyOooEc3hDa63HwNXV9g3HS0K5zwoBhEQ215I6LyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqnX0qeNc38+ybjd0tI+8xerh3G9rWX4X5AvEtVFqS/RMc6WJeyNILF3dWqUocM6xCq7qPMw+WGd3XaqnUSz3JOLwut9b4mWkVOqSH2iSx2TkdBMk+6EaDLZ5GK2K7oov34pw+IXnbCnxAhTvRhICPpZseoWvaJyqqi9KW9j23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdzfDXY8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdzfDXY8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so18360765e9.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791826107; x=1792430907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YveKtGz1EIX08GUJXyM9GGRIHFuaJbA/DcyfZ3t4Uc4=;
        b=sdzfDXY84WUlI/Rjx0/3TOTE0KP0+vd63gknL13AM1rdJfJLV/u4yYhUtlvhPtJUUs
         lYGjfioxJl1JOhQ7ClWZy6xrz1UzjiPZuGXSUO/dkG8N1AuV0bPXKceg+UmktExdavP5
         P69v5Zd7ztAmc42LZUnglhryjxXpdwibbTiL+b4ijR9GS+yZxdmz3oFnd94I7hAI28y6
         C1dDGIspeYH5oLVdODTup1N9G8cY3kvAxzavacNBfM4k8wOYcdiJ9Xd+4+i/2ZRJOAzB
         M4TTDYyKMQQ4T9A4kmMFFj07JinW5Mea+YXvCisg2HwC5ZbmW6dP7G76r7RJ7An48wgp
         vY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826107; x=1792430907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YveKtGz1EIX08GUJXyM9GGRIHFuaJbA/DcyfZ3t4Uc4=;
        b=opyS/qa1j3b8eiCx681THn91j+BG8maLL5YushdpOFnbIn+PyNd/V+blddyEJoFOe8
         mjS+NVyhcl77jBLOAyW/6CnWMPks8PJ2R/glwoO8pCw/32YQiAZMDZcGMarCrWug83Ee
         G80oC29XQDk8eJtfMPGlN9/0D24VwyxoesRMVuJYW85jYvGzeiI4FpGsVw3H1+4iQ7nD
         FBuFIEXXAWIBeW0FHmSGSa2KHZz52i3Jq2NzxOYxjN85ppJTUf73N+fJ1n5HT2lxtG4A
         QMzz57es7syWzEJmDq5YsS+//+WTlJ7YvsRwK+hcNr+iLr52wmaEM30B8EHf0toIshfT
         UfkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOGcoKTWOVIdKTAbnoBSrGt+ZR+KDzHmX+GYn9hI6ugcuaAqDMWf1h7mF19iZ5bZ8ENrqoVx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaDdk22FwZTX0sLa5/ASgh/MIsDyS80HcjxntHK+ta5J/+DKhz
	B+o8SqGKXg+bf4l07KEGzfIgxiFHdj60MYYN+ECaG2P7k9atjUSfM8mGg0FyCn0T
X-Gm-Gg: AYBFou3dvxSubG35Rbh3RL22R7g+ORC6taKq5MdGwRCTPsMI/1+ea5Splc/rN0dgAJh
	EbeqCp168ewMscXI6k1NsCqV4/LQ5lDyLE2lK84Q2mRF1akf0BADoEZzjPeRyT9i1YsXV2JO9N5
	1BsdFOANoC1xNwCSwxc2YeRkUPtAbQkkUT2ml28aI0W/tdywRP4wJB8Jd6i+0tv6Lw35gXfyCRc
	C55neOAaFxouhbf3XMSXpq8H0wPaVC1tkKGVE2rcCdwEE5NS9Fi/LbMvOkJBwZjmcIIPdj2hBW3
	+5zfsUVB21aKkFi6tpYouIE56tTSmbIBWeycxssrT9U25SU97UBZh3KTQ14v+gsHOpcdBCPtcqg
	CSGUHnVzbGKV9mW50esbEZsgTXSqqyslQ4Qs3PnMJEsKyJN5rT10uYr7MU2vR3VCL0jMSQM6CVn
	U3MCY7KRiVvU+32VrVidckgRbzq4ml9BVvUVfX6qG2JMmt1I0lvTcI/BxT4UKVMJQLOgdRDWq5/
	ynuwE/0206IhthtEFJE+GSlKLgNotvtfQ==
X-Received: by 2002:a05:600c:310b:b0:4a1:813f:2a5b with SMTP id 5b1f17b1804b1-4a18e4a9da8mr184355265e9.14.1791826106280;
        Mon, 12 Oct 2026 10:28:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm480991455e9.8.2026.10.12.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:28:23 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0CEB6DC09FD; Mon, 12 Oct 2026 19:28:23 +0200 (CEST)
Date: Mon, 12 Oct 2026 19:28:22 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Brangs <erik.brangs@gmx.de>, benh@debian.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, 1149377@bugs.debian.org
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore
 working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests
 firmware)
Message-ID: <as0YtvgukA-Gp-D-@eldamar.lan>
References: <179104011040.2214689.5921682013387867802@eldamar.lan>
 <2026-10-04-1-daily-reply-0007-bt540-asus-firmware@kernel.org>
 <24ce058a-28b5-4499-9ded-eec9544b80ec@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ce058a-28b5-4499-9ded-eec9544b80ec@leemhuis.info>

Ciao Thorsten,

Thanks for looking into this regression as well.

On Mon, Oct 12, 2026 at 02:00:18PM +0200, Thorsten Leemhuis wrote:
> On 10/4/26 18:29, Sasha Levin wrote:
> >> In Debian Erik Brangs reported that after the update from 6.12.107 to
> >> 6.12.111, specifically with the backport of 980084de4d9b ("Bluetooth:
> >> btusb: Add ASUS USB-BT540 for Realtek 8761CU") Bluetooth is not
> >> anymore working, the full report is found at
> >> https://bugs.debian.org/1149377 .
> >>
> >> | [   38.138881] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761cu_fw not found
> > 
> > The stable code matches mainline. The failure is a missing firmware file:
> > rtl_bt/rtl8761cu_fw.bin has been in linux-firmware only since 20251111,
> > and Debian trixie's firmware-realtek 20250410-2 does not have it.
> > 
> > Marcel, Luiz: could you, or Christoph Zwerschke as the author of the ID
> > commit, send an upstream revert, or a fallback to ROM firmware when
> > rtl8761cu_fw.bin is missing? Stable will take it for 7.2, 6.18 and 6.12
> > through the normal Cc: stable route once it is in mainline.
> 
> Hmmm, that was a week (granted: with the LPC) ago and nothing happened.
> Anyone working on this?
> 
> If not: Should we revert 980084de4d9b and its backports? Or only the
> backports to older stable series?
> 
> Strictly speaking it should be the former due to our policies wrt to
> firmware -- but I guess most users of a more recent kernels also have a
> newer firmware, so I wonder if reverting the change might do more harm
> then good now.

If my understanding is correct from a earlier fixed regression in the
ariea, aka
https://lore.kernel.org/regressions/0fd8c1c9-7f56-4bcb-a727-e4386d8ef094@online.de/
should then not only 980084de4d9b ("Bluetooth: btusb: Add ASUS
USB-BT540 for Realtek 8761CU") be reverted, but as well along
6f0624b4427e ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
8761CU") and as well 4a23ce935f74 ("Bluetooth: btrtl: Add the support
for RTL8761CUV")?

Regards,
Salvatore
