Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765233;
	b=KtsSq0lO1q/RHDyRRJ4th43nqWaai2mnkdz23cx5G18uayvYD1DjngTDiTKHUDIAByq0
	 jIcNEmNZntR0CjBKdJmmePRt9Hx/W03nWduc7/gneWGNbIXwYqXFAOfUab6I9aKRQpZsW
	 nCXyxkYDenREYwQrogjlvqKczu+18ReuOQHa3oLyi1gPrbtL6PdWgVoAoRdKQ85Iap6Pz
	 N/YW2JTVRVJ/nkHo1Wz4roIywtp1BrKWk8RIUqUj4bqyxuXIbFqaN37mGA+YK8qw2LVMn
	 0BMkCxG1i1vgvwusylGmc1nu3ry/TeMmKp2xZxmmoguMZMT8k6IDJ8QyR3fuyGVkhYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FYelfGeWVxsW2UZatn9i0YQXv5kE6L5K7G5kzhhdsPs=;
	b=0ViFMR/9TobEBU/T7wN4MmgjhelKaN8tOTeJ6mvsAOhRyyKodUyWExclac3nY9OzeerF
	 XTAUkkH/h20XJ6ofs1VIEbZXmR4cTtMAkWFWx89KDz05psGtMJVeZbopD0TR+VIF8h+I/
	 uzp6TDzArCOTn8nB57IZ5bARgkCY2/z3pWw/IXWDj5rBmI/JSiNad+l37FBGL9e3R908r
	 BgZ2A3hXyg1GnZj1+RMkdvNICihvUWc9nRnAyV0Nb6OIaacV9CZ9GMbbzVR4GE7zje8Jr
	 yV0g7a1h2ZOJqyjBn12moSeGNn+us/c9GiR3Vf9hP7sQ6Q30xvIpVuHC3jmKpMpB1NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TtuB5SUy;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14947606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14947606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TtuB5SUy
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso10988695e9.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792765231; x=1793370031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FYelfGeWVxsW2UZatn9i0YQXv5kE6L5K7G5kzhhdsPs=;
        b=TtuB5SUyv67fkiS1u2Pi+vgi/mV/besUg+ihQ993/t7PedQfmJwAfOfwqzfp82ZjDa
         eplY9aegS1QdW9r/Rn6ptTlYSYfwjunZdP08RKH/QXKwdaCpGXe/NP2QlXTgCymK4d8p
         kbh2Gdbw9bekCgNgWJm9b3eXooqhNKJkgMxZ4c7ir5q0wSfgVIhvJUesT/nw46iSeEXY
         K5PFtjj6d6KYlA6wd+C8AI10ApTBpXJ75lHAPv4wCfKabtrgxM/DTqScLTfclT44Bqrz
         tKNq7sngNz3oRjlOVZsWh3/Y5//cji5LWt/lCwfv22q6lIDXUerDoR7VAa+jO44n8Jwj
         spmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765231; x=1793370031;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FYelfGeWVxsW2UZatn9i0YQXv5kE6L5K7G5kzhhdsPs=;
        b=hYaLrrWkHF2Ry9k/i78bZYiqYX2epRt6htReGLfmUTYZanVtDB2MN81xZlkiwqpr+k
         jUyQdfphSpE/WJ3yBWd7CBO1nAtkTZuFrydM3dlu/SrTzKS4NKKR47mABls3bB61JihQ
         VWTtLhTRE+vwQME29GlWmOTlUZX//SbfL/3RtEmNa3iypX5k0LRzztu4xnKBihAIoAo7
         IDTHwButD1kIUszJ5op/LHCnLE/a+y3Lnp1DMwhSQTSDjcbiG6gU71zOyoTJae1RbCTl
         BSn7/INBFlxKvVvbY+qxbVq4XrGwsGRiy51wQx8j8HCadmm04LfQQkGqrgrmuNLL9Opo
         Nx1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzKn+prVDgCDd7qMME2GLvufYmgKFOmJiAsNpUy/o/HypSBhwWTCpCJOxHa/NnT5jPxoMFDbh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfSzGBNIXMrj6g8dtRud/LLeuEQVyqiBDXLWPi5XufNN335T3z
	5Ad+BkPQg39YxKYGegSA65aAx3xf+wc7jwlv5/XiyqmR3YXLXzlVxV3WmYOYeaARGzk=
X-Gm-Gg: AYBFou299zSLirAtTTPizfIRacOegcmLvE168nod7GoUZrShfBXACtYvnSHqVYnK23Y
	vmmRaNmQB7x2dtLLUAlQ9FcAwda6DZBTwRZdn1OrBeLcAfcc0YkJYewnMD6HZviemYpX1X4ena8
	Pp9RlCNTcgDs5q6IjnDcZ0mkG4KBzkPg/Et0E++76/gBCHnK41XEx//ksBAf0eN/Jco0Pfi+2eb
	WnEdiSBJ4recjv1Z8ttPQsi0EvWD1H1OjqDmyT68f4xvLpbW0jVcnOVCSNJxwHDGDzq8DCQVjzx
	qKts5bz30CQIkh5HOg7F4Zg32Q2AfxU16340rzph+whG19/2QV8JdzGS+2PSmcMGTd1gb6tEE/l
	fJ8JLmR4FniFthF4wvW1JYebVVMtvlEcgRxMTkdsLttb4TSBgMZgvmQlC7tC1Ser4JAdM0qEGzl
	B569NTZl9m8RfC4xUxIuHU+0jk27o5Ucwb98SVzjUc455bmYt7S/ubIdATETZY3hbn9ploiO5nS
	QNE6oMRwZHS3Sp/T42IVWuj/0J3HYuaTkZF3eh0JeCctLRH6Nhg8P/Mydpc4n/OGRjPBw8t9B+f
	4gSOSkPzTlRkX5xaE+O8lr2f8Ikz/eM=
X-Received: by 2002:a05:600c:314f:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4a211ee0412mr44748235e9.17.1792765230946;
        Fri, 23 Oct 2026 07:20:30 -0700 (PDT)
Received: from SurHub.localdomain ([102.213.68.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d3ee6d8sm112486f8f.14.2026.10.23.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:20:30 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pablo@netfilter.org, stable@vger.kernel.org, fw@strlen.de, security@kernel.org, w@1wt.eu, sashal@kernel.org
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Date: Fri, 23 Oct 2026 17:20:26 +0300
Message-ID: <179276522631.26562.2889534736321613077@gmail.com>
In-Reply-To: <2026102330-rockslide-brunt-8616@gregkh>
References: <179235055956.10524.6485282696272965887@gmail.com> <atU2brRgmeb6ght2@1wt.eu> <179236182769.4914.3317139682579833845@gmail.com> <atWvQFXJzJ434qGd@strlen.de> <179239012164.14465.16534329674629579851@gmail.com> <atXZxmkU9Yrv4h_b@chamomile> <179258686469.28311.5894488032414438351@gmail.com> <2026102330-rockslide-brunt-8616@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Sorry for the confusion. The patch is the 6.12.y backport I sent to
stable@ on 2026-10-19:

  Subject: [PATCH 6.12.y] netfilter: nft_byteorder: remove multi-register support
  Message-ID: <179239371327.27230.3709565488726931662@gmail.com>
  Cc: you, Florian, Pablo, security@, Willy

It is a full backport of bb061d3de4170741 ("netfilter: nft_byteorder:
remove multi-register support") to 6.12.y, where the pre-bb061d3
multi-register path is still present.  It was sent after your reply:
"A full backport is always preferred ... Please submit that and we will
be glad to queue it up."

Sasha queued it on 2026-10-21 for 6.12 and 6.18 (queue commits
d9a6f49f787e0de7447462ee9f63de72ca9ec8c6 and
1eed0466672b84e1b50c149b7bd98886670f65a1).

There is no separate request pending: I have not sent anything to
cve@kernel.org.  My note to Pablo was only answering his question about
whether a CVE was being requested for an issue already fixed upstream.
I said I would follow the documented process after the stable fix ships,
and would drop the CVE request if the CNA considers it not CVE-worthy.
The stable fix is the part that matters.

No action needed from you; I am just waiting for the next 6.12.y release.

Thanks,
Abdifatah Suruur
suruurism@gmail.com
