Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08C406837
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542532; cv=none; b=tUsbOrjQbjZJl5hPH9CYlQyl6egeF4kJ6daHP6sbWXSrR3yBrTksAMxJtkHtV80qI9QWt8i3NpyoRifDvTzPWp+XLamoJJJAC09nRP63QddVhTXGn9XfHc7PJrDXzBCGg1NzTv8Vwr8MoTwW/fipuE+KqErbF9RwNP9DnG+TMX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542532; c=relaxed/simple;
	bh=I0czcqaU9NMs2BP1zo2pCccOyInTDzyoIcCagwGCQa0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=j0vvybBhrAdipmSvvWnEFesQa6fza3WhYlmTNw5428TRzBh+GIlVo3yOYO+mSqMo1zOjG4lIh+NHhBmE2sO67Gh0+gEPPC9mIL5VG5lCmoRXFEtqHUe8UDBsw9qdLRJyjpCWO6CWk/eMkhvZ/+2rMFT0pQks/51HQz11Mbu/6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+DrsmyG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+DrsmyG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49222fb062bso26293405e9.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781542529; x=1782147329; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I0czcqaU9NMs2BP1zo2pCccOyInTDzyoIcCagwGCQa0=;
        b=G+DrsmyGxG8auJbnueAyykbiT+VOs4viA5ffOMDhvmJWlJwFmvscSan7NJpptssvTf
         VN3eTgzVb4zJ5zZotjqRO2D8r/rbfhmTfr3G2Bkeu5RtIDWwgqvHryKm4KTwIpYvGY7f
         xknaI0eSBB9ODxaFXAjKtso5KEA8EakBvDgxLO4IpGaJ+ktqGQvpbnzvrbgVPcL1qoIo
         OVzvZcJ4Hv3/kY+5sNpx/bJNoeMTVut2zlCQdqIJkVR8ublKV6bgZqnvyeaojXnzNrbo
         d5l5rObNqllulmYhXDCLQM/tvLRppzxE9FW5DoqEHYG+T2EBrH4ah4gx8RIrL03jZMPo
         K3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542529; x=1782147329;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0czcqaU9NMs2BP1zo2pCccOyInTDzyoIcCagwGCQa0=;
        b=LhauunbjOatSPJOkhigOA3wY4DP3jjxdtofelRw5MynBqmJgBvETvNv75tkbisQ89K
         oYyfFgXTVVR1F+EFPHh0LS6uxWe/9BZ1yUYj+nm+FsN+GHbfW27Mq+FJNZ/zOxMh5F+h
         aLTzKcbJGcwhFRVrYjFOllv31mEdBledmyOIeRTsq5I8DLu2jKYDQBUtxvRNQqIjljeq
         hryDi4K3kY/0u34Pk7KpbeMVBYDTj7dZZxuzzGe638mKGsoxJALUqgpcF+suBEGlUMUE
         oWOTs03tW5CO3wV1jiMjzz2af3v8pnKqkD4UH/E1U5ZM8agLVd5NAaentHZdKQyLB20p
         BHpQ==
X-Gm-Message-State: AOJu0YyTfS5LRX0x/MfHuyUinywdCtMymRYDefbwdY5POKf7KFwtOMit
	w/I5AFkivtWOAjZLguqJWejIxTADpIPrRp86dAD0u3Txfg6xHNTluG8KetYIwo6D
X-Gm-Gg: Acq92OFpU4K94AYMNhA9DiSxA5jD7FL6ZVNkGQr/uMy7pNan1xLqBVXQgO2WbBLz1WS
	OQz004fGp6IEFoZgIf3qyGNTgE891+UHUnE4U80NuCtTG4AubuiyglGUfS+DvJ7gsO9Ois9hudX
	cOW7WzQFtpSWN4hD7LKv5Pa8EWFe58wkx/v7CG7Mk/Ignz3zpYlvAlK+2BYD2x1Ie4j+a250sU0
	S+XtIZOrjm+lN5FYc704QOF9hq8HD3jUaPj3+mwQSE2kcU6o0Q5ed3rZvpEsSs47sgLwqf6tX7S
	/YUhbc9VxeIRQlV0kqF1tjOw0zszM0fZoyFHJCpE9J8QxN+n3/LHtCJ9S2IVXtPRU7XX1KbZsCW
	hXo0s0VSVVArk1b0d4ol7gUlX4VbRSfxJcho5Jvp2JHJovS/DZXWxvhSDU5Wt+0+oKj4ZgZ4lLc
	P178ddUovVfVpuO4d3Vy6aaMzyTaj3oiTKNusawgCz02EfLQKh7tf0frwS
X-Received: by 2002:a05:600c:3b03:b0:492:1e7f:d426 with SMTP id 5b1f17b1804b1-4922ff72ab6mr599085e9.2.1781542529291;
        Mon, 15 Jun 2026 09:55:29 -0700 (PDT)
Received: from DESKTOP-LAN43DA ([39.46.252.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263945sm36643165f8f.8.2026.06.15.09.55.28
        for <stable@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2026 09:55:28 -0700 (PDT)
Message-ID: <6a302e80.d5af3cef.1ca29d.82dd@mx.google.com>
Date: Mon, 15 Jun 2026 09:55:28 -0700 (PDT)
X-Google-Original-Date: 15 Jun 2026 12:55:28 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: theosilas.mypackagingpro@gmail.com
To: stable@vger.kernel.org
Subject: Customized Bags and Boxes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQoNCldlIGFyZSBhIHBhY2thZ2luZyBjb21wYW55IHNwZWNpYWxpemluZyBpbiBj
dXN0b21pemVkIGJveGVzIGFuZCBsYWJlbHMgaW4gYWxsIHNpemVzLCBtYXRlcmlhbHMs
IGFuZCBzdHlsZXMuIFdlIG9mZmVyIHR1Y2sgYm94ZXMsIHJpZ2lkIGJveGVzLCBtYWls
ZXIgYm94ZXMsIHJldGFpbCBib3hlcywgc2hvcHBpbmcgYmFncywgYW5kIGEgd2lkZSBy
YW5nZSBvZiBvdGhlciBwYWNrYWdpbmcuDQoNClBsZWFzZSBzaGFyZSB5b3VyIHBhY2th
Z2luZyBkZXRhaWxzIChib3ggc2l6ZSwgcXVhbnRpdHksIGFuZCBzdHlsZSksIGFuZCB3
ZeKAmWxsIGJlIGhhcHB5IHRvIGFzc2lzdCB5b3UuIFdlIGFsc28gcHJvdmlkZSBkZXNp
Z24gYXNzaXN0YW5jZS4NCg0KTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IHF1ZXN0
aW9ucyBvciBqb2IgdGhhdCB5b3Ugd291bGQgbGlrZSB0byB0cnkgdXMgb24uDQoNCkJl
c3QgcmVnYXJkcywNClRoZW8gU2lsYXMNCk1hcmtldGluZyBFeGVjdXRpdmUNCk15IFBh
Y2thZ2luZyBQcm8u

