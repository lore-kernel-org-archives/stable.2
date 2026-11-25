Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617256;
	b=q98i1pI73PGWcDWvU74ShMWg5VcSOWIh+NwHgjzXc+t/n1Uq49L8l6Z5RBiY7ltB43lN
	 OXVSLlDxQkHdySkVzYXrlJbvpnndAzP0r+qsbAP6yCuqHYz3zZlY4dTkkWkZvHs8w/Jkr
	 rlmsAgCA8YMzZc7QcVDZbRxsLFuUSHsBZ5a6+N3xBfZS3U7FZZA/T/Ibpodd6hhV86nuL
	 kVKQyCr9HXXH5i0rIH4bqoPx5Jb2518b3/YBZL15jcLnor3/eboe8o+ZaL4OfEwCjf5rd
	 8sWg97IV9uSM3yyuVBjJQkXL8A9hscJ/gAMIV7WghxmODn6lk2MiVx61gUx+8C5jpcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xxJJVSNNwo3lBy+JEx9HLHLWgj+DbeQNPp/qofQE6mI=;
	b=mtkYpFEq+8/V0U4r3ZQEJ/BQnJp+oqMEJVTjH2Qnuq2wQe/9MO0m9kwvUiJVFaUxoVay
	 E5gRMLagO522WrZMuQiGRYrIPHCIwE9xk606sE8Jl62M3OHViddA5oLiSMmQyHetMvURj
	 oTCteHLKH2DS88iIGsiLi6nNKwDu0poQZU4xeQ4iNsDhyOFh4rk9KZic9aeaYRFrSrrRg
	 zttrDvvWUuI9q8eJ2w0TjA397M6d399LDerYTp18uCDvtE+cWLzrhGdjqBp55HKhv+v0R
	 4+1HN1bW+TFd+h+EHNX3O0ynlguOIp2OpcPZGs/rouPsUFddjXUb3c8XhICgUQL6guA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=D7gB3Q6b;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB7606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DDB7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=D7gB3Q6b
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490f38e9688so4123303f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795617255; x=1796222055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxJJVSNNwo3lBy+JEx9HLHLWgj+DbeQNPp/qofQE6mI=;
        b=D7gB3Q6bDh+RP1I86PNUMsdP0gQXykxJeokg9RnkIPnPcMu1SYoBIqlhk70uqqO2Qu
         NwWT7ZwbJr/P/N8PqMoi5RQq7LD+W8WLiOPdmlUJLIzDY61aw2FevAkOdMBQiuZwDoJz
         1fDZjz0QKsPDF6GhRb2uua57nXezvczAjwUqPopF9qDJKpJIMEyi5Pq5LOkcEoQiw50x
         DErCOttxpfJ5YcX0J0opbbJHS5+Yy4K2wLBEJWBL9HnegPncaMhLPGnkFwEtJLvO9eGX
         V1odmv110NSbfAcQb4UyX27cVUHvT0h+MxqBt5qeeMu7Rrdu3O7n1s5MDsBFmS/tnJF7
         BZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617255; x=1796222055;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xxJJVSNNwo3lBy+JEx9HLHLWgj+DbeQNPp/qofQE6mI=;
        b=cQlvRvySCmgLDsNkmsbEF7oJfsQCyUuJivk/BQ7BVq+l3IdxGfviA1WkRaiI1S3NAZ
         N25Ryqr+hvwv2t6xcDD0PSJX2VeFI54n7QYtrFmykg4XvTJKZMSCN3kghkBG6S/XqebT
         y0nqB0eEQFP60DJGIJLE5MGhM5mn7BppW4bGLtUCESdgGrJhrfe+f0MyqF2vqDKam9jx
         CynAFIBRq934Gv9YTlH2l/f1JIAdXoX0E87JJIkGINtsvQEvXo3zP6vEMIlJQgXFsgil
         Q+K55XImfcJDTBKV2l1poerXNJQuiAqxtmAmTPuMsk7vYtFJkQBl5eSEF9xHY0gqQjLD
         LpnQ==
X-Forwarded-Encrypted: i=1; AL+hErHx1Juv0MQmBh6pJh+9aFHlZMWSQepdB2FR+vn63tHdHMPVDwsSIwHBthw4CduKujbZ6a/JfjI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qSWchMkAsC5PiaxeZFe6nhQbwx/0CFAMWTuZ4CKxCcqvAjz0/
	8A2nw/EGqx6gxLfl6cVRMAvVgeoIJyw4zlqleZuVa1sdmQkg5S5vNNnA9R+mWReknPzHFNnqZ0R
	L4Xzg
X-Gm-Gg: AZFdTZfRoZlr+UvsJwbSedCztATIenPuXSYFVW8u7O+4KL54p+cbcTx+VOs1NAXJ4Ea
	PQ7o0fUECypSwv9eaqms6hwWh11mAzVQE3OFtyIvA6V6B0Lup9KwrfwqOV3Zhj5raeAGRSVpBM7
	XfgNcYAdP8QVngHsr/19OTku0UW4bQzMgpjMfxNMGc01bX5FCrQ2aWLE/sHLIiIJFf6b0eECEXd
	0u6s5IGmWmyRdNI1vu6/eM0uO44UKD+s1gqGXNk1LNYE1kIiwbyA2vg5atY2wmqVRoP8CiP5rzw
	2SQ3jwrPcfRSEprQh/wqQmWlEjf4IeEWYMl2GdWrSApcMEK3MZFoKe8zd/g3lfRI/pKT0SLPhLO
	uQlbjOiNN4UL1e8W89Q0iv4TVB/sDuDWILxumBg1znHst2GJNBLHoEnUk80KZRfw54pO425rdUT
	fRopTyDfJyaTuYM10TcgdlK2XT6g113IorLEXO1lyHEIYygCbeWNkADkSPRjnZSURM2fIahxxck
	emfDp/IHmhgHc63C56WZy4R/Q0TqnZ7MogZKb2sr9DhbMdY8JLh8PPwjGSzwcJ/MsZ6PnA58Gq0
	APCbzSNhI11TJOSuLDuXXJyKaSOAaafenqFeVPdF6q00oNxhG+95D3hYWQ5S0uWGrr9taGepccD
	CizO1gu5+cQ==
X-Received: by 2002:a5d:5e01:0:b0:492:2b36:a149 with SMTP id ffacd0b85a97d-4aa59ffe3c1mr43267193f8f.25.1795617254808;
        Wed, 25 Nov 2026 06:34:14 -0800 (PST)
Received: from ?IPV6:2001:a61:133a:da01:7767:7f7:9a1:80e? ([2001:a61:133a:da01:7767:7f7:9a1:80e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm33563359f8f.56.2026.11.25.06.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 06:34:14 -0800 (PST)
Message-ID: <7b4f33ab-088c-49be-9b64-f8abb808ab29@suse.com>
Date: Wed, 25 Nov 2026 15:34:13 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: image: microtek: don't receive REQUEST SENSE data
 into sense_buffer
To: Alexandre Becholey <alex@becholey.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20261119084526.535901-1-alex@becholey.ch>
 <643a71e0-7347-47f3-8cad-ce31f76cb8af@suse.com>
 <AP57iwtzG1Kr6EB4hY7F0Hd-DaLhPZJzxoKNuvDpeiAKZvyxsddI1fl6kRKAc2Xg1ox0kL-KAdNYmZrRMEYN_mZRamfiV6nXjdcfDhJhGyY=@becholey.ch>
 <e3956050-8b80-4270-998e-2e5ec70cbdf8@suse.com>
 <8iDv29vCFEOxycORJWCZZoTT9dMFbUZZ9VK25sT27tKoWWtaKvLKZaW2YoQDygTrSRkZRE6Pu5PmkMFLl-PDCWXI9n1l-LSB9aJCByn8gks=@becholey.ch>
 <f9715edb-94be-47cb-8bf1-f84a3323f000@suse.com>
 <HSkiYehoEZjHsmtOkLlo174eN2wrhaDGyLpIMwWTMy0Cdn4t_nrRvoS0dslql-VSF3jaeKvglXyGaJ6OxnGMs_0TMQVXRUFDK1IDH7yjR58=@becholey.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <HSkiYehoEZjHsmtOkLlo174eN2wrhaDGyLpIMwWTMy0Cdn4t_nrRvoS0dslql-VSF3jaeKvglXyGaJ6OxnGMs_0TMQVXRUFDK1IDH7yjR58=@becholey.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25.11.26 15:28, Alexandre Becholey wrote:

> I understand. A fuller cleanup is more than I can take on right now.

Not a problem. I understand. It will go to the long list of things
that should be cleaned up.

> So I will send the v2 you agreed to: it only limits the transfer to
> SCSI_SENSE_BUFFERSIZE, so the device can no longer write past the
> sense buffer. If you would rather not take that fix, please tell me
> and I will drop it.
All is well and I hope you took none of this as personal criticism.
It is not the outcome I hoped for but that is not your fault.
At present we have a security problem. I will take a clean patch
fixing it.
Thank you for doing this.

	Regards
		Oliver

