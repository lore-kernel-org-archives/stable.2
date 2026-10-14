Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F552116F4
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944394; cv=none; b=hJAcx84LsZRM1zcGVim5x3l8LzGUNTh1uak+x2Rl5sJQEmm5Q3JiQFSvgoHh8wqcdoceTyQk/CjCCYVzdZLNEAewMiWGK8mLK7n1msDAXpfhzrTNafB34oPIbuhaVL7HgCkjC5F0/IsncDkPFoO+cBs5sfZNnb3BwQWSG4j8JSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944394; c=relaxed/simple;
	bh=8pqy1oMnA2IatGFDWtUZXA1HErxM5AAlotEenJvAgOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=te4uTE55YqfDTYEV50JmKYPIgOWiBTAyJyoq+Oex43NBeHHyAIoiQ4FM9+jDm/p+rRujahttaAaWcbglxm/QNdrpvqguTkDvtmXT0iP/kJjgvOQQWNHVcq9VG4fwxjSVsohnE45W+JiGMnwaXfOezr+GXG3scqGvjn20twzLbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=CNm4TTdi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="CNm4TTdi"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc758830601so297531a12.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791944393; x=1792549193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dU08fQsiwmOWxma5Ng7cjNhVY585iQcW31VdocSDwx8=;
        b=CNm4TTdib8ugggzjdkOUa8lS+AxeMxql2xxCXkEu+ptgonlqku2kVUKnS27tpFnjOe
         LZi1RDMeCV8TK5tjblbazaQ/Lz94k4ImwO72cx5dMwphwyLYI1zNrea7hhs53xzqX5iq
         Yj6BvarwUhwW0xJ2W9BNahgxf5TUQzhBnF8BrSeIkVxZiePvbCKB9YuAnnbB5q+Srr6X
         0hsOkAfz52BzA5Q7SW55xlYytu9VffGOLWSVJCuYQi5bX3/0ww2vxmtfVMdFICIPlBi8
         usQ5wpAXJvyRbXyKW1k3GF9uQVOvCfjgOOdWhxoPwlVJcVAUWPEZ2ONEFIhVEoSL0knn
         3I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944393; x=1792549193;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dU08fQsiwmOWxma5Ng7cjNhVY585iQcW31VdocSDwx8=;
        b=ox2weUPs6fKXh2PELqAcXbisi/W8+q+Ik/62YOpnXm6Ukq9LF1bvNtfhy3DnOlZezn
         RuMV6SnZ7EWCmNfcQj2G8NdYztJ8cQqGR9j1BoUSW2ez6idmdf+VuOH2oi/LTher+YQU
         kXtohs6AHywa/fuH86FuLpx9ttRJw9cMixMCHWt5BHh0TQPzHYdRw8UzYkeLfFNBPDeD
         1xeH+/INh3LNpq6iT9dstrhMd7axwbvUiO6h7GrixzCwMl9+162VRI2rsbQJgvKjs5Zy
         vAzzT6n8djeIQeHPCn9b06bXi2nK+YEUPtHL0wJw5qVz7RsO5kVukYoNPZyTLAt1gbos
         sj9w==
X-Forwarded-Encrypted: i=1; AKwUvBwOAFfmnDuRUfulrYrrk51SW0G7BlJzb2IvxBY45MbOXAYIGwk8QzngNbme0QFz9IHwyIc6r6I=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS9UTpMa70np0cjTkZ8M7U9vgCLBZQfOfmDrdox9+hf1ya815Y
	z58Y0gZTnVeV/nBUAeOb0GtFbG9yIS0qBzRRoTjGRKtQcnSxzO1ozIJSGUdRyPs9RYI=
X-Gm-Gg: AYBFou27q9Y8DrJtMgyWcNeY/YlPxkoo5Z3t4x/5D4nwtvOTIEojnlXgI8oG1Xa9q3b
	R5tRxL9b5QMUNNvsTLeaUxqDn5KVQGfpvMGbboK2GiFSNiRRvVY1WYVSZ51pUXjoy7PInc1Jl6m
	Z++eM+f5+LaiseE6LI5HHryO9sxOZ+u/5poxlvMfePvAznH9NtBIH+/rJeVZ376AAXm9n9Ynuik
	fx1FCUbNave3kl1WHEh9e0WzI5Ak4nblEXu30L4o6/Dw8C2W48+JfqfcfkzVyGHgSaIg06arhcU
	zq5bIZNvYwGZvTrJRYxii9zdyujl3Z/BW5RdG8arqm96r5Nxj9OxyzpLFxmkQ+KwmbFAnnEgRvF
	PWORlhy+ytwhC3+okx6MupIjfHTCNzHVRb5hGYpEQtJig1YKefsZX2+oVol8PbENiXQ3R/eP9uk
	244o11rQGZg6erVTFOq0s3nbgXWmQiVQBE+8RL2Tfcc30xTdoVoJFdptAUSbyNKpFA0J7NqEIFy
	kLQunApDOpNvj1nmkXp
X-Received: by 2002:a17:90b:224c:b0:3a8:bbc2:5551 with SMTP id 98e67ed59e1d1-3ab3a0f0a1dmr14151443a91.0.1791944392675;
        Tue, 13 Oct 2026 19:19:52 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f05083fsm2254652a91.1.2026.10.13.19.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:19:51 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sashiko-bot@kernel.org,
	"Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v2] scsi: mvumi: reject handshake sizes that overflow the list allocations
Date: Wed, 14 Oct 2026 11:19:44 +0900
Message-ID: <20261014021944.3486511-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-170674@kernel.org>
References: <20261014011808.3479480-1-yhlee@isslab.korea.ac.kr> <sashiko-outbox-170674@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks -- v3 addresses the reset path; the find_first_bit() point is below.

- host reset: v3 rejects a reset handshake that reports sizes larger than the
  ones the buffers were allocated for.  mvumi_init_data() does not reallocate
  on reset, so mvumi_hs_process_page() now compares the new sizes against the
  current ones when MVUMI_FW_ALLOC is set and fails the handshake if any grew.
  The shift, list-depth and list_num_io checks already live in that function,
  so they applied on the reset path in v2 as well.
- find_first_bit(): this is in mvumi_hs_build_page(), which this patch does
  not change.  The 8-byte read on a 64-bit build covers list_num_io and the
  adjacent ib_max_size, both members of struct mvumi_hba, so it is a read of a
  neighbouring field rather than an out-of-bounds access.  It is pre-existing,
  and the only input that makes find_first_bit() scan past list_num_io's own
  bits -- list_num_io == 0 -- is rejected by the check this patch adds.
