Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEEA175A8B
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104107; cv=none; b=OPdsCfzzPN425L8Nt13SoJsxGUD8eMCwltgbAcF7wsyooe4lrvrAtro5fViuMKmheKAhNsItgEJWKf5dJqTmHc4IgTaJ6ntQNuwD59fIqJNnDqLAU31MdDrciijsBNhof1qiZzrZsLoob7kOXRYp5d8S3oQUqcrwpBVSGCC3p24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104107; c=relaxed/simple;
	bh=7zDtK1+SZ1zwQMNGkR53n6SIlbE7b0OVVJ8QZq0aRRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqNS6KjTdcbJAnWwRUJL7fzKSlNmAMyjdgppGLYDDJCPY1RskL/tFVZgB8WdtXNbFykQ/iVFLICNVPj+dFo9g41yunwB3JoRwnCpjxHfsFs0W0/EglSFVwvv2HYdU5UshPPr+6C9LptXsWY0FmN0qGZdfZAMMVB3PS66wlIhQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=wQkjyuPy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="wQkjyuPy"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso558940b3a.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 18:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787104106; x=1787708906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=siuYPloOqsDQiXuJrGNEWodYtqI8v97Pc5mC2E0cvrM=;
        b=wQkjyuPy1wsE50PrHHezZqXeY9ZNaX3VyfHLTQNdajIkY7nTn89OVj1tj/fiF3wEv3
         +Dps52Xdl1nOdTCdv+ixU6afPmx/NfXz6uu/KGL1/3l0mG4ORjqbqrAMGqt035J+ziiH
         SVu19m/zwGp79t1AFgvxU8RsW0z2s0jOKuUmMrVaBIrkUNiEpkafVHlHSwGSMSG8hVtc
         U5yKa7gAo/t7HFUQE5zoxY/zE5ZitYHp9jvK0BF5yEL5r27vwlcO6F7sMsCNXzze57f5
         O6MeACgbVoCWI37SN6Jon3f7DYpaPyjRV7Ol4B7meue23q/7XkUD3VgIn0fvku+Q6wim
         HgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787104106; x=1787708906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siuYPloOqsDQiXuJrGNEWodYtqI8v97Pc5mC2E0cvrM=;
        b=TLXmIvELXg0wr0gYfKlCNxKu73k4ILTbkczS5DxKIVGLWaux6KA6U7A5gkCSVauT7Z
         IUV0vFkCbwM+cxVstFEPGfzdCuWh7IgsHIbEYZ7JCwYfcAtezmcrkqb/5m+us4lTVFO7
         aDSIVj+qUzRs0f5rR7NLRiZSqFjSmxBENTal4ZMLbm+dUUVHw8q6YysiKHqk5WFZSWJn
         ot0tLfrWEdhoJ2NeYdI8Gxv8jMVpWQQshSKE+dR/9lSkOz7Iel/rv30v4Yfa0/x8xaME
         h5jjlAbxlUbwGHDz9E1nvTKhFbKRiwXmfDWEAIpmlmtvhzrsaMdD+kdLKeRpFYQGAo2A
         +WmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rryu4hwYzninlpxipNbeFUFb3TeQA8aICSNP2CwxDKutDiEussLxWBSIu6q+DhGOfLjNnb668E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFmQS8bfHFihhM1Q/IQPHpd2hlAKDGhfuo5u1shu0pYk66qc5
	ruugFhJwmNPP1KBX0O38msOp3oxu2IzGivt2A1qKM2OGgFdLSZNm1UBBv+giszU+Q4s=
X-Gm-Gg: AR+sD11GlpwJje3XaqpXYHVEZ1y0/lKT6/ZgtLZ9lH25kE8Byh+H0BnWQxwXbbAZ5mv
	1b9K3BkDR+U/trfe2NY+yjXowrHok5Ys8bBAoLyRXW4+JXfSL4YQ09gf9si2UHxziFPXgpG+R4N
	BXVcm2y+TYjF1OLLKPbkhmmwoyj3/6+FYTSpVpQqeIOFI+mYnSKN/HSx2LnuV37MC+NJvxkjPYd
	mVMYbmqMdrcVK8PvNeYW4pcCseWtSjmWjoGyUZcXIapxTnTTpVVtrEyMykcuFnfEYFWEoyQInbR
	lsqVywUOL1RExmdk+kTfXRBIHsQLWQNKYaDl+S6bF19fIEke4rIrBFH8EnIRuI+APk2r7CmWIOt
	rUC6YJCnuEmJg+L7rr59cnW4Yb1hJ0hMxfrslLOxXQtrisW65mNW3BsQvLtiZrNJHVq2yO9LZ2o
	Xzsusi9oElmYg3IGJRs3fodKi+VbCoJo8pvwoxqMpdjyLN44I1UxSIUVWFEO1t0rppA0keLOyyb
	89o4P8=
X-Received: by 2002:a05:6a00:3a07:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-851d36d2909mr1516620b3a.4.1787104105938;
        Tue, 18 Aug 2026 18:48:25 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d33a5b72sm79345b3a.23.2026.08.18.18.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 18:48:25 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: bvanassche@acm.org
Cc: linux-rdma@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] RDMA/srp: fix use-after-free of a request in srp_destroy_qp()
Date: Wed, 19 Aug 2026 10:48:15 +0900
Message-ID: <20260819014815.642500-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/18/26 9:26 AM, Bart Van Assche wrote:
> This patch introduces a race condition because it associates a single
> CQE data structure with multiple concurrently submitted work requests.

Thanks for looking at this.

struct ib_cqe holds one member.  After this patch ch->reg_cqe.done and
ch->inv_cqe.done are written only in srp_create_ch_ib(), either before
the first QP exists or after srp_destroy_qp() has drained and destroyed
the previous one, and both writes store the same value every time.
srp_handle_qp_err() finds the channel through cq->cq_context, so neither
handler reads the cqe back.

The sharing is not new: one command posts up to mr_per_cmd REG_MR work
requests, all carrying &req->reg_cqe.  ib_srpt shares ch->zw_cqe the
same way this patch shares ch->reg_cqe.  Could you point at the two work
requests you have in mind?

One thing does get worse: "for CQE %p" in srp_handle_qp_err() used to
differ per request and now takes one of two values per channel.

If a completion has to identify its work request here, I accept that and
will drop patch 1.  Should patch 2 then carry Cc: stable?  Patch 1 is
the one tagged now.

Best regards,

Yehyeong Lee
