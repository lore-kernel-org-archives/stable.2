Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794688427;
	b=vRFURHuz0f6Lf11TwcMxnIl5YveXZckjDzkXrZMjQf7ado8SDRzb/YRmeyJJGU4sjiS/
	 rmIPHLMwHR4fwLX0EqwMLAB5hzgyRJ9xTOPbCb0/+bMCDRH3AKV2GS0wSWfpXcjSxMD4w
	 kqPIC3WsnJqThwYj6mFz0VeNJCFjsOutZtT7E339kBVTWqJ4m2ohFV4nj49rfGMvkCiZX
	 1ve87KN1LGvEs0os1bsgBx1tSqKwD+xSSWCntw8PGsWlB7uHAes3QsVngCUoLjRc7qY2U
	 BpEEzMWDSvIYP3fr//LnsJBVaMVntDxiW2QxEGRlF/P5eu0fqgBZDsiDNdD6lYo94bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794688427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=mUNTxU6y4TEUEh2QskFJN7r1v0olPGCGxnMzFiH63eA=;
	b=AUF+umglJxUgvf0vn5DuubNwpKszIafW1LspsoQMth00VD/NMO1udguo1WsXMu2kzEc2
	 gBB+kuVVXHE8ObIMcyJbwH5Q7dXq5yrpj0+DqiFi0z2SgIeiOeP9a5xKngSJBIQpLYNkO
	 vuDU7SVbOxXOWwn5qTeWGFjiakLZ1FP3wPqCNkrKjr85gE+gje1nAFBrbDnEENobVHTWn
	 dfDUj248ndpBPIywdWRpSPR1QYuLYFGrd8DkMbBalXcvxuJXdzsA2MVWXKPr+7DjCwDT0
	 meIbx2P2ROr0EuX7ZJ6NOojQmU+xgcRJ/sn91BmeusnMtZakYGRGv1yK8i+D2hw7yKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=uymy2ub0;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB7606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 20:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCB7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=uymy2ub0
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ec2d42231so35263826d6.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794688426; x=1795293226; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mUNTxU6y4TEUEh2QskFJN7r1v0olPGCGxnMzFiH63eA=;
        b=uymy2ub0Zijc0G3JOCyduPFpd8uQPMdNsfes4Z2FXVzUBywxjJIiq06aljmqVRvGVd
         MkG2MBDLYkaODgkaRqb3LLLF20+YlPv3bRmudBF5Ue4T7J7a1l0o/v+v8bqhdJ8kfra2
         1x0B0TgCOS7ULF9jrFrA4Qc+Fya5NDoDUGqrVXqwlrNm99DvwiMdUe2PI/9OYQiN/UDj
         2A7NTVOz/NJq6Sb/wKyi3MsngPX7fz7chyL1hrTUwr9+2zEAVYCZUQU5AMGu4OOc2xEr
         Fq0ywvN0l4NKvjFJIbupmKUCqhzbndiIr2WMpEuualU9UoVdMmYN7OZVSb59JWktHXJx
         dlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794688426; x=1795293226;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUNTxU6y4TEUEh2QskFJN7r1v0olPGCGxnMzFiH63eA=;
        b=CLcshx6JEj8OwOqzGDYfvIevUGRIVPOpm++tw9cEK/DmQvFrQY30c391+9lxkeNHAc
         Hj70d3tKq0OvIGg4wOkws5GzSyREeG25urtMkRTpIsGx6z4dtRxa65/7bPev4aBOXCLx
         W2uL/t4XoCatAuTVel544EQX1RJb2/cTtK63Q1wcjAt22uaI9kk43mv7nJnNtjLhOYv4
         myBAdBxzF4/zaRqZXLs2oPN0Un5sU+tNjPY1NPDl0kSBAjwt3nGq3xUADJ+eBeq4ZykH
         BekRmPvUMO7Dd7MRY8H2P9limRWn7KTq6VRWgmSdKw2QGhh+mKhkMuTKmUFmJNaOxL/s
         P6NA==
X-Forwarded-Encrypted: i=1; AL+hErF0LJuHvQzQ8ASmGlSP+eCc81QMc4loTljjnd+n1TrFtIbJJZ1Rye1FkE48QyOiRESIW0LtY68=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Eaa45fQ3FBtk+O9cswD2Uz8Wxjy3/6a16g9HvoEjHjJ0u9kVy
	1PLPn6VF1z60b9N7hk+dFyErPqQBGLU2/vXg4JPgfnxrXHY7OsfuijIexcBSOKMT9vA=
X-Gm-Gg: AYBFou2zTpYVtr0yi6VMY/ualiSiuH1G+FWsH1/ay1jfb4HNp38czAmJQporsuAgWSA
	0EGEZcuVcx5SoIXvwSlRH7gdm0NfqGR88rQj3cCvQHV+iKKsP2hNjIyGrf883AMfBfYpHFnyKa/
	EBz5sUtxH3Xye+opHrqmIcYZOnsdHgBIsdRryqBTDEC25knyAZqgURnyhs0nP7dHRiFnSB6KWf4
	hS863r99pRZapJrPdm2PwefrEACxD7wNMO113ScmDkOqRrhRyBBZ8hq0Gt8OeZtnHXFeMLUXzAH
	QBGbUWn+G3upH8OMig/QYZaTGKaDPdhUkB4jqCHgFOVFg5K4l4ENfZQc7WfIhnbNrbo3Ip4jr0A
	5J9v7qqCuESedWDD0U52KwtTdGqsKw009LDiavmuBe8399IxKZ53tudRODuC+Kg9OSLYEfrt1LI
	e/5X6SJAb0RQ5JnLwXHMHS8QdoewGirrMQhe5F2es2qZNTLpzT3wWyK5Fyh1oRK8lBo9Y3qA9xB
	Q3ip3VBpiFukY5AI5tHhdMx1IRsWEIzVbbvMliexdRM1gScaazdTxt024YSCHiA/SxoiaLtInJw
	iklmKxJpnBERjKTWYhPFoPJgTWqICP5DTJvMegH6yFrbhIrJKukBxhVjzzliVyqR9Cg++K6JXez
	HkecHZHk=
X-Received: by 2002:a05:6214:5291:b0:919:7384:99a6 with SMTP id 6a1803df08f44-91f24246723mr103621956d6.41.1794688426276;
        Sat, 14 Nov 2026 12:33:46 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d954e1sm49818366d6.33.2026.11.14.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:33:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] mm/migrate: fix softlockup in do_pages_move() with
 huge page arrays
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: shao.mingyin@zte.com.cn, akpm@linux-foundation.org, david@kernel.org, 
 linux-mm@kvack.org, ziy@nvidia.com, matthew.brost@intel.com, 
 joshua.hahnjy@gmail.com, byungchul@sk.com, gourry@gourry.net, 
 ying.huang@linux.alibaba.com, apopple@nvidia.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <avifKRgR0Q4WPUNR@gremlin>
References: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
 <avifKRgR0Q4WPUNR@gremlin>
Date: Sat, 14 Nov 2026 15:33:45 -0500
Message-Id: <179468842502.482102.17860580592179578567.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-14 17:51 +0000, Lorenzo Stoakes (ARM) wrote:
> On Sun, Nov 08, 2026 at 02:28:31PM +0800, shao.mingyin@zte.com.cn wrote:
> > From: Shao Mingyin <shao.mingyin@zte.com.cn>
> >
> > do_pages_stat() had the same problem; it was fixed by 8e934ab44389.  In
> > current mainline only alpha, hexagon and classic m68k can select
> > PREEMPT_NONE and they cannot enable CONFIG_NUMA, so this mainly targets
> > pre-v7.0 stable kernels.
> >
> > Fixes: a49bd4d71637 ("mm, numa: rework do_pages_move")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> NAK.
...
> And absolutely not to this person/script doing backports, thanks.

Have to agree here.  This is just creating backport busywork.

This might matter if we intended to do automated cross-arch testing
on QEMU TCG on these platforms... on those LTS kernels... but also
mehhhhhh

Yeah we shouldn't encourage this kind of patch spew.

-- 
~Gregory

