Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02E49CF5D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355100; cv=pass; b=RalG45gbng8+E8km3t+0VrrXost1GdqK9UeXyriV4zJHO2MEvAbXPAZ3yj+EhQW6ngLAEOw/zHTPj5mFtY7L+5ByHZ7Qev1zT4+AwO5xH8kfYZ66XkJ5w4xafsFMxRrcV7bqje1UuR8fa3ua0v9pwGGZ0vHeFFqAf8VRVEMPfz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355100; c=relaxed/simple;
	bh=vml0uNQKeGVnX3dK4hM4ngGTCQ9mhwmQP0hmR3tD3e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KN9rQE8tciNcDYRrkuGgzAdfeGE2GyByf8boY6b3B0Wqgs24pyYLQW4LkDsUqdHa5vhFrmeLEYSVqzfV0eYUD67blvYmJ14eG/Ry33dxxDqt2KNoJ6WzKmnzEAMLHoDCaOVfQc9EtiM7pt5b5YIG3v/l+m9QifJ5p5isaEnzous=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wvb4RYqQ; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wvb4RYqQ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so1179696a12.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 06:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788355099; cv=none;
        d=google.com; s=arc-20260327;
        b=cfTDdlP4m8AsfgbUCZWJUtFxeVUIIflZA5NUYqmhdOAYOM8WvYjlZbfBlkjHC+TQ2U
         XGdvZxRsXuu8T6HXxwkUdo5349UG620LEEhhZWPSEZCNWk1TtxadWeBFKaBKu463psZc
         KEriIufDhawbUKBkMgSg9dFpK7KA99dpuGBIDIalIoCrI54sZU3ye1sCXq1QEJJcvC2a
         3LbVG/LIsZa+Tkxuq9ruvXV7riLWBPrGm9d0JTZ9uchjSiMZQ6TFXWjyOW7JgRYTwhfK
         XZH0Ypk7n7X4ie2mt98YKIxc02UicyeQUFBrkYiZromYk6cfHAG1PNIhrD8hSw6Sap5Z
         P6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vml0uNQKeGVnX3dK4hM4ngGTCQ9mhwmQP0hmR3tD3e0=;
        fh=zMHheGBqEPknlFHGYvpi03IUiTIgN16FJo1ciR5Nf90=;
        b=C2fYMizKbIuAb3rAqkVhUt96zFzpgpx11OEyHy39qZ6XvbHDrUG4e0P+KepA8JQCz3
         EddxLQTalKoq7yPYZTEo3zZtZxif7a0rzGXg1P8s0prM4BAgq3//JjZaa+8q2J8zT0re
         101xI0WTQ2Khd2IjPeqiKINhVJ5bcu0ZpNf01sY37CTUzvQRkzpa6X4jXlifoNZ8cf+b
         zVeZtYTc6f/6qBFGci4fkgXFFtvhRX4jHI+Mn8yuT/xn7PZ5lSd6G1a9XPb6a4f15q5r
         HDzo4NF54DQ6oKJ9ErMeXTiQ1mpwYr+RPygY293DocVsVTSu4M4pvD+PDB7AeS7SxNpD
         q87w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788355099; x=1788959899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vml0uNQKeGVnX3dK4hM4ngGTCQ9mhwmQP0hmR3tD3e0=;
        b=Wvb4RYqQFwFCHrMpp1GICo4nvbSvGkOh/MaUfYQxYApRp/jm9uD8rnxznnasiMJ2JR
         QwgEWjEDatGNNXVqnzuLv7WNaIuaahPg0Vsw4mE01pQf7HKqR1zesLue28mpwudjtFpl
         v9ka0zElcrSOOFUyfUdXWZ4u8wOHdlRBrAQsFhjv4CaOpC4WJlGAIIJKrEF07ghw8M/U
         bFgePv/+Xt8pCTkr78DsgfN1lKN8Q+Ycr0kba4ZJrdvE+JZdBSkaRISS7TUoKIQQgRMz
         b07UPPBn1GbPKHeN9iIAnHXNCehdE2YVBMhk40+nBKEk89vRLYUxKsdPh2Ab6M2GXV7t
         HnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355099; x=1788959899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vml0uNQKeGVnX3dK4hM4ngGTCQ9mhwmQP0hmR3tD3e0=;
        b=aQ63nR4MR23LxEYWQ17pDz4QW+V1KuDFHRORzUysDiDiY3qQp/mcJPpl+InM3Qjifq
         oy5v8ULI+I+e+e9SMaYvkcR92jOvAmHj8c4iz2I7bzs3G2R2b+2z82r2SmBj90nV1Tcc
         ld4x301zdvM1pGtrCXxCzsNsxCYueQ2ndBThycePjzjd9Y3VZA3AJYZu5aZigA7WCn5k
         C2NazT5x/KUjctfgjPTV4oOtyHzQECbkspzc7W8DPIAAAw3A49dTzaG8hAVvkSloDWNi
         GoaqxfsEA2vUgwL3dgpckf0LN3/eypgjHmM84n5CTdnrILEkrNrwAzSSd23pXK56Dbt/
         APlg==
X-Forwarded-Encrypted: i=1; AKwUvByWXnuNsNYoVNtLArVju0s3LKG40OGpq3KBX6uPWsgRX70uB1JqXxngoYiC1L/0D0pWuE0YLYA=@vger.kernel.org
X-Gm-Message-State: AFuF++mbL9tAFUc17ByMGL/LEITu7Z4ur1fSUwoT/vA/LPqiTL5BEMnz
	t/S3OE9AuGD4O0AfN4gkGIhbouZptexOz1qWXTwWE4x2q0buJPR5/F2G13yz0d7kVO/FBcblNo6
	isxJdElWWJBz4zHodp/xgMZa0i2pKAYh2u/TeDXpk
X-Gm-Gg: AYBFou3e0THYMTlJidLjfMsu2wWQCOu8Ff4LCKqGQnfE/EiZNMGnew0UGp5umJY8+zx
	LZ1yW6E+4hMwqJMSwE5hur0DW5NhHluFH8pjXJv5GEqnltrCls3GYiGMBgyqVBW0SZqPmZ/g5xU
	7S4dRvi+kbMVghURhOC7rgrvqaK+uMbDp06vsrdCAf5/spvcUsJIyU6T8Hj8Mf2efGLL9fvatgF
	ikGuYxzkOshkUlwuCADDuLaL9j3mUDmMwR8N3PEnsI2xOcxyIO9n6cyeimaK8GeU369XHeFVvsw
	OgkUwMAKxMtettsUyL808JrCOu+3tNHhjcbClI2ECzqCyXbqUtRLUzLmNLRtejXlCf+IFwLqlA=
	=
X-Received: by 2002:a17:90b:2750:b0:398:e73e:5a0c with SMTP id
 98e67ed59e1d1-39aedf5d887mr7396769a91.1.1788355098217; Wed, 02 Sep 2026
 06:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901124013.1098560-1-xiangzao@linux.alibaba.com> <20260901124013.1098560-3-xiangzao@linux.alibaba.com>
In-Reply-To: <20260901124013.1098560-3-xiangzao@linux.alibaba.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 2 Sep 2026 15:17:41 +0200
X-Gm-Features: AcwNN1XM2BzITGqUSo0D8HPYIrUbNX9N29u8ucC8F6Zcs9BqkJ7UZhQH1J-LCJE
Message-ID: <CAG_fn=U5we-NBw=8j_dKJzoHU5V2bDOh3OjJ1arqZQusKRy=JA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/fred: Fix stack depot filtering of FRED event stacks
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com, 
	luto@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, akpm@linux-foundation.org, rdunlap@infradead.org, 
	elver@google.com, andreyknvl@gmail.com, gor@linux.ibm.com, 
	brads@mainlining.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Xiang Zheng <xiang.zheng@linux.alibaba.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:40=E2=80=AFPM Yuanhe Shu <xiangzao@linux.alibaba.c=
om> wrote:
>

> Reported-by: Xiang Zheng <xiang.zheng@linux.alibaba.com>
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Acked-by: Alexander Potapenko <glider@google.com>
