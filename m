Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B94908A3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585816; cv=none; b=EPxtrIDqQgN9tKBs6tBVqJtxN6X63iBMS3dOsT78zMslUmdUt8ltc0FT3vju0ZBa9Ka6tO6rsMcjYkvL+EIhAcPSiIZQEmZroqricax+kPzA6ZHQuFn9aGj/cOj6oMElTWEzOUQnZ6yPB3GCvPmWklHFPAIMU/ZkpojFnUSCYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585816; c=relaxed/simple;
	bh=dWhyAImIfrgrm+GktFBPHJ3oz0UcioWGpy6TiaEbbcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tMT83hieVZCo2EKqW4hIG1OZOvf4hA5r5MWgq0cqH2ER+llFza4DDJYhZUiIUcGkeubdSnnV9ViuwmPsw1d7pCIK1pDnFbXoz+vNJcGZZxs0IY1cVNIRNB0KetnRrS3c96xI147+PSbdGl0bUtmNH3MGrPT4J8PJhOdcn7Q1tj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=AAztSuf1; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="AAztSuf1"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43da99ddso12207527b3.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789585808; x=1790190608; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnX6TMlM7TkvtbK7Ln9VIw2FWzmoodBJCcoSVeS4ETw=;
        b=AAztSuf1g4y4Pn7zC2B02/TsPk/pZSFhqpyrpJRvS6P3JbxOVQ81LSGL8ueoNsEytu
         JOYCar++n3MOzCvbMKAiudY1I+V38jgT4L9rL62b+pp5lqhBDgzH8llYWCLr2EeR3y5n
         CMvSwtggKS4bBKnPg1l+4qgmW8O9I/coYEZvBGuZMo+Usucm85BBxzz79JeYehfE71DB
         BFyUvDS5WMzLxOMecyXg5RhR3jO7MqRrXp2n42Orxn5gTB9axDEgznT44OwEIyelHuqL
         ii2y17JyRz6h43CasMYMpPXw+dV6ybd8S4SVoPE0jaEdf4f+NQpAtSLutYCR8fgLzjgr
         2FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585808; x=1790190608;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nnX6TMlM7TkvtbK7Ln9VIw2FWzmoodBJCcoSVeS4ETw=;
        b=P56q/WjyJhh/9YSJstZalIixfOxwcYyiYULLibIKwppTFn5qB48/tgiVJ2tvGvAGfp
         3uUTJsGWYWsWbITlMV+SmThlI/2+IcahTHhpbK81SoqkY0ZYVhr9uPOCg/amvaep38OP
         BlZ+upQMHyVyNHW0eitN8hz42IhiHjoCL+TCrbCwqdDNId7DaKXNZJIVpAEQPwJYXIkm
         2KinT3GocikmiffhsgMs2M1DSanfZeguZiiOwc/u2sS+STd2MMRSznb37GblZTLI7IZC
         5OZWy35wb1KlVww/e8ZT+da20fFQ3K2bPtt0+oX4SpoEfskNKHQC/ix4UmvzzDLRxzUQ
         1PRw==
X-Forwarded-Encrypted: i=1; AKwUvBykCq/Xnx46h56Gvb93xpefKbAwxGdSkJ3NbQvO4hp8WCgWgRhdI00M7Zd+veQN288zI9amzrQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kilStg0xRqDrIyERQGa1vyVHWtjSFwM6/Fw5DQ5prG/560hFBr
	1PcVmvZVXnuE11h7MqwbyZLlPXCIJq51vu4cFe1Gm6uBufZfp7D8um5DhDEI9ptVa6E=
X-Gm-Gg: AYBFou2uA0zYNTw1o0Vut+yzvRxi9/hv0DGaCWcmOxqBPGH+Q7oc5Dx9RkBtHFI6hkb
	W8SaMCrc+zvJ2rgtk/Ru756TFfMr763brVbA0B5QLN8AHGlxHuy7ksNoZdPLhqW1DMPM6zDwujE
	teMX306umwk4uK2fJU9jJB1r6JHNq2WYmbwlqQxR1WeAw2+KLLAb1EooHrymWPOP4zoi0XvfSFt
	Ju5rQNFxD0mpT/c1E37+1fknW8C4/HEFTLF+SKJaRB1/jCYxAklrVWdM67QGgXAwWeCoyKUie3P
	RH6jseihwBoJqBn3KVbNVulBpLFfOCA0KpBRRzh6S4c0T2RSvVN8GB8CZOoB6jRiB3iBTN47vgo
	s+VjRUl3lV1HAwxvv3ZT0LxsPtMjlJRPGoFRL59xq9XUlPKXOo/Aug5UHmzrDulwr6JpduRaWx1
	b7LPoQZGo4092wSw0AK5tryAma0PBPd2ESl9OoJ9qNTP4SNOTLVeo9Omd4/90RBODLvUjOxUixc
	N5jwHAmtS82HSVU72bpbI4y3AVTsHlyzFzUvO+wiSjCaNup/VdcAN254DpPbtOvTMMDQ72tYAb8
	Ktx25VtvwYqiwe32PorwEwPyp8g23lnCG6IKr7xmPtQma3sVHzFdqfEuHhf0RkNH
X-Received: by 2002:a05:690e:1685:b0:671:3f7:9cf1 with SMTP id 956f58d0204a3-6716321385dmr1421432d50.25.1789585808172;
        Wed, 16 Sep 2026 12:10:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f547:a2c0:72f7:6671? ([2600:1700:6476:1430:f547:a2c0:72f7:6671])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f79a963sm1664399d50.20.2026.09.16.12.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:10:07 -0700 (PDT)
Message-ID: <07b8c0e199af4df459668e6ddca0eee10a735956.camel@dubeyko.com>
Subject: Re: [PATCH v2] nilfs2: validate file block counts during recovery
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Ryusuke Konishi
	 <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 16 Sep 2026 12:10:05 -0700
In-Reply-To: <20260915195752.3337033-1-qwe.aldo@gmail.com>
References: <20260915111351.2726334-1-qwe.aldo@gmail.com>
	 <20260915195752.3337033-1-qwe.aldo@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-15 at 16:57 -0300, Aldo Ariel Panzardo wrote:
> nilfs_scan_dsync_log() trusts the block counts in each on-disk file
> information entry. If fi_ndatablk is greater than fi_nblocks, the
> data
> block loop can consume excessive summary entries and the later
> subtraction
> used to derive the number of node blocks underflows.
>=20
> Reject inconsistent file information entries before consuming their
> block
> information.
>=20
> Fixes: 0f3e1c7f23f8 ("nilfs2: recovery functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> =C2=A0fs/nilfs2/recovery.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
> index 4d5a6aa521..28200cef4d 100644
> --- a/fs/nilfs2/recovery.c
> +++ b/fs/nilfs2/recovery.c
> @@ -359,6 +359,10 @@ static int nilfs_scan_dsync_log(struct the_nilfs
> *nilfs, sector_t start_blocknr,
> =C2=A0		ino =3D le64_to_cpu(finfo->fi_ino);
> =C2=A0		nblocks =3D le32_to_cpu(finfo->fi_nblocks);
> =C2=A0		ndatablk =3D le32_to_cpu(finfo->fi_ndatablk);
> +		if (ndatablk > nblocks) {
> +			err =3D -EIO;
> +			goto out;
> +		}
> =C2=A0		nnodeblk =3D nblocks - ndatablk;
> =C2=A0
> =C2=A0		while (ndatablk-- > 0) {

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
