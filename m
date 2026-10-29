Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244460;
	b=V4+RbwQaRg4f1fPM4cnBiJk2W8Ov9q3IDbJ5MPinLIuThP+nIKjXfsDn2Twlrk4f4CBw
	 sL/LUAHSncEQVij/hgVkTkb3Az6VvX1+f4Zb+/5elDTAirsWOMXRqN4XvsKbTTFeMqWbN
	 Rv425PEbfAwZ0Rs6t0zddX4WUXLfPxWDQQHMUU+puZcRb58DMIbEjs8OZ5XT076KUfIFv
	 tOeMFvsbu0sEN8f4Z4gJKPLRp1it8GDl/SSjZoggtrO1yvsmt5Z8077M6ijhLmO/SRK8W
	 J9mIll1RcHd1mbtLsKhFc/vEmLRYQfdBQgr9rAPiVSj9LAEx9nyX333dGDrOeLR4nUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=0DjsjpXU96UP9kDusHJgpmPdkD8cLQUHrfge/mnRBFE=;
	b=mt+HGt01Ai9Ih039US85G76HlAIeMnbReojle4VxcWJAuUv8UlYf1ZURHUHE1NlNIcGR
	 dWiBmK94RK88sknw09SBs9HkC2/nbnOvIb2MVaOTiEVlOgBrFWsff6NaAppwrhKXd6e23
	 MKXeg/mudP1m/4B3bTowYgX/gED5GjGnwjLfdXYqKYStiKV2VZmU5Suck032yQHDYvQeg
	 l1eN7QV0Laol0V51entkB/evNHJT4WmiUROzlS8yksQOwnaiftunWS5c2KjJoY8qdhMnx
	 ck8JH1UjtJSt5KPrJmqzKp6Ti5ZwhPWWx6//ohhCE4g9i45/DocKVeUAegtmbuEJ1rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gmSxhDFw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE0606A327
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DFE0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gmSxhDFw
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T38T4k2581560
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:27:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=0DjsjpXU96U
	P9kDusHJgpmPdkD8cLQUHrfge/mnRBFE=; b=gmSxhDFwHSvjFfh3grfM61H6IYl
	/+Ns3n/+6o8BFC6o2G1GzFtYw23HbA6l+EpCNLDr9pmO56yEGTYp4GlY41fcvnw7
	7YsDSeNG9PCpxfL+ESWZH+QcFRfov2pfCG/7pfgsl5czd7OimMkuoAB89+OmRojZ
	QnqBaA+FJLPouNC1oia7VKdQTjybhJSi/uQhjlKFhWfWgaib8ZjHUSwVuuaekVvH
	uWvSyIwGRewKHoBV2Qf1OVEsWPYIZIGtAlh19aeEBvx/2OW2Zj0oED8wpjHcOy+7
	5RP+qo19y9FifMRm/HXv0PZKOl2tiFANfsyzsKf9cJCSs6wEl4A/8CRpkrQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hk1q62xug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:27:38 -0700 (PDT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1663fb7e005so2068834c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 20:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793244458; cv=none;
        d=google.com; s=arc-20260327;
        b=RTDxvsB4tHRiTrtXZMAIz7+zK/aPswfgk9JYHCgPvKGdwaNNjlh1MgStHDH0pDzmCK
         V0OO4vnWnuXB4EeppMFLq/zNhLp+bgorVuPWPzRiuolhRt+onBEZSz8wXy+8wAXCnPST
         VmpCCOrNgf/B1ts+oj7zqDJr9C97lLIUzIWJO7eQMRbHB8CZqvz148DfS79J8FsR1dZ5
         amq+cKXINLZcixJKgsUWY/wX/1kR7S58LkutzcV5OYrM/NhLlSQagDwxaMpOeXUUrUIT
         luUkgIRBil83uQtXNj/bQrWY0dgIywjEo713sYoV8nOO/lN8u7bo2P8s2NWJdMN5m1YS
         j+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=0DjsjpXU96UP9kDusHJgpmPdkD8cLQUHrfge/mnRBFE=;
        fh=Lqwef89EeCcheGVGhEg0LRNLqKYY20ZHBZWsTLMzxfA=;
        b=i+FLsSQv96XtrWSjF5SzTZjJEnujnPCg1cevkrklW/p+TxNOlOk6tewx8JqXGUkh15
         Ew3NYiY0CoUhdmB7av7FPiaVW1fuI6LB51rfsQ1osrJ/EWpd17Z61cucT2TNQoDagK6d
         zIM+xLqHffiArXwjtAbvr1lF57bupspPX+FYNvOa511vSgrEBB3NmkFGY3qtdstvOdyl
         brZgK+0HV4jr/nrk5Q7XT/1o0fLoDlju7m45LMLBfXywKupxPlfzFL6SsDG+8gnmwt6I
         PheNEKOYIp90Y+kpJ+ZdRuUwiCBLB13svBB3W8MkUj6XtvhUk9VjEtOdj0s1PBy7ky1N
         Qz4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793244458; x=1793849258;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0DjsjpXU96UP9kDusHJgpmPdkD8cLQUHrfge/mnRBFE=;
        b=Ll6YTR3qBhdqAJOhv6BZx1h+eGmAaPynjPyJxpGUidKgOpFX8ALn3tiv+X3Wn1VNVM
         jT/EK162LnSDM4J90M/6qt/2woxCzvq1IyAaDTNwTCOpGZPpF9UiKxFOX7xUlQsGbC2T
         CnGdiOR88k1Yr2xG8Pk/PykZ0UCbEW/L2HJqnfUuFMIJWCKbn6gXKfKIITR3P8bUl+Ue
         Ip7PBbACm70dnQZir+HUpdn9sRJUWcXozbTwrDFkYZtwoBWx89q0CZLudK2bgwShv+Qg
         WpdjQ6ceZwN/HFDrROpY0Y4rxMIciHkXeZSy/4aTXHrAJyFRyzWztnMKaLS5xCt6M3Zw
         gQ9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxmj8rf6aVe2bqHrjyFBxmYBo4SYRgBxnzhY7wMHdZAmJiw6U8N0xLqTzEwkfnt2jdPi6JIHaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGOTtd703HczweoCVcEt6+moSbP5hnH8LgIxdWGq9QNZASmH7o
	BgxfqdQyhgGh18gkmMLTxF2DVuNYDLlcO7M9W9ymHDB2NTqUKsmkwIHV3Z6ltGkf+Gk8zA9pjCy
	tQcTVu+HckK6z2olU30r+6zvSH+cfczRpELgfiBqS0N/gLJFzM4p9TAo/z+9iUOvylneuMXseIi
	u2GK10Mn2pn0Jj+GahozPZyv4Gff161rI=
X-Gm-Gg: AYBFou3DUvJO6tegayyqyQC1ApTMfdtRv8VX4pRQZ3Cwzj6D7eZ1ePmsc+maRJUn7da
	mwLeky8A9kNy9Kb4U8O53JHB4zXCSPJN9tNfAsUEcweNvLUeDhQDGxQA/H0kDsRI4/9z7CZl5yG
	H79DVJm94W/gVDFF3BQERrSGUur3h5cX95NoG7fLHVwe43elGUGLat8Dk=
X-Received: by 2002:a05:701b:4203:10b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1a6c9af1e26mr5876956c88.4.1793244457474;
        Wed, 28 Oct 2026 20:27:37 -0700 (PDT)
X-Received: by 2002:a05:701b:4203:10b0:143:3c9f:10a6 with SMTP id
 a92af1059eb24-1a6c9af1e26mr5876935c88.4.1793244456694; Wed, 28 Oct 2026
 20:27:36 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026201101.3915217-1-leonming@meta.com> <87se1qhvz7.fsf@igalia.com>
In-Reply-To: <87se1qhvz7.fsf@igalia.com>
From: Leon Ming <leonming@meta.com>
Date: Wed, 28 Oct 2026 20:27:25 -0700
X-Gm-Features: AclHuK-KIZ_96J7m8EUFsiyjK1WGV9FQATfT66Y3r8LemRe76Zf6qMGUQGEgGVU
Message-ID: <CALJ5FXmnb0QU3KtmE-0ieX1ApTSMG0gZ+Hg-TSeG1G2mLd1itg@mail.gmail.com>
Subject: Re: [PATCH] fuse: set dentry epoch before making the dentry visible
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joanne Koong <joannelkoong@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: G_w1Fsdd_WDOu3ez8Lapbu5p2qodwsnk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAxMSBTYWx0ZWRfX+KpvsgEnnm3l
 tEuj7xuQGBDJ9SL2EzZQYLvp5yyGrk4nPo1xnheRH+TDJu7zHI/hP9BEHDS+A68AqiRzkb68EYY
 8bJbxeFIkj3H+tI3jXlN504ctbS0r/q5IMtPYRcyBtWyv8TcldTSzluUV7KhOuWb1TKsR2YmbUT
 7v+7tpBuDWKz2mVH71R7k6Dd2t8vONP/hK+YhcyD4/w+F20Q/fGWtCdDs6jrKfARFUDd61lnDVp
 EfI5J/5jS7W8UPTJoxd/70xPJhfYCjk+eNVhSLPf33yp5SeLKcS/C77g8+4ZAfIq9TCLAUmgY0l
 B3OCH9jIBf9wKISK46nSx/7rajsc8PGCvxRPx9e9UKTx25xRR/eh/COZdosISb6GM/nXEg4HZTD
 F1/biUUtJdztZVegw2TaNatyuipC+FWqJjXqumzN+13eY9vZC92ZZYQUE5Lg8KojMb3OUr2mrvf
 12z/FjAoY4cR0ajhHKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAxMSBTYWx0ZWRfX3JJrACJffeZl
 UBEJwgTFWtFIlc1aAaAeunERQowy0fBF2iKSUz5tREtpChyDzCbR9pABzoOhH2JiPU01vGu2htT
 p/V/FefbsTDwOBgwSuXNd9FWqkVQm/I=
X-Proofpoint-ORIG-GUID: G_w1Fsdd_WDOu3ez8Lapbu5p2qodwsnk
X-Authority-Analysis: v=2.4 cv=V/joQuni c=1 sm=1 tr=0 ts=6ae2bd2a cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=V2sgnzSHAAAA:8 a=lT1PLGjMyznquQLvSy4A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01

On Wed, Oct 28, 2026 at 5:03 AM Luis Henriques <luis@igalia.com> wrote:
>
> On Mon, Oct 26 2026, Leon Ming wrote:
>
> I believe this is very unlikely to cause problems, but we're slightly
> changing the behaviour here.  Before we were setting the epoch only in one
> of the dentries.  With this patch we're *always* setting the epoch in the
> dentry being looked up, *and* possibly in an alias returned by
> d_splice_alias().
>
> Can you see any possible issues with this change?

I don't think so. When d_splice_alias() returns an alias, the dentry
being looked up is never made visible: it stays unhashed and the caller
drops it (__lookup_slow() and fuse_direntplus_link() both
d_lookup_done() + dput() it), so nothing revalidates it. The extra store
goes into a dentry that's about to be freed, with the same epoch the
alias gets. The alias itself is still updated after d_splice_alias(),
as before.

In create_new_entry() and fuse_create_open() the earlier store only
happens after the server has replied and fuse_iget() succeeded, so the
error paths don't change.

> Personal preference: I'd move the other fuse_dentry_set_epoch() into the
> other branch ("if (!d_in_lookup(dentry) ... " ).

Done in v2. One catch: the alias returned by d_splice_alias() in the
other branch also needs the epoch, so v2 sets it there after the
IS_ERR() check, as fuse_lookup() does. I added a test for that case; it
fails without the alias update and passes with v2.

Thanks,
Leon
