Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263721FE471
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650579; cv=none; b=kjVEOKZJ6pEeasbMDQEWXyoO8GosNZuPkQ23w6hZDFnNYONET4FKz6IsKSiC9i+d01U7unQ85jCNpuMKn1uaqA5GSUubarswvRZuOUK5NXIUWFlfOLbOzPluAoVQn6jH6Gh5GhpRdV/VyLZhDdMj16kt19q1I95n5pKiqvo0qIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650579; c=relaxed/simple;
	bh=d0G78OZFJtynCYU0Yb+pYf0nAFBSfE7NY4RUeGFmbTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=leQzjVFeyK8Ic3aC37K3f1lohV8RrcC8K0n6anha7bqgdIvDMlXnrEOoJjU6JVh91zc3LX7Iz5Ih5/cHbq46sQapXedAhqTzNAqPk+wzqohW5IHyIg1K7Qs5Yspv+iuSrXmXFckP/T5O84ezSk4U+OAkt75GEa5+6cBu1VTWfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4U+iSm1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4U+iSm1"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c22c61795so2719911cf.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650577; x=1784255377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/Wt9nwIkWLRPZshqrH2chvmAQIMoCZXZuZQFMmUS0Y=;
        b=k4U+iSm1ioHpmAPYyfuFjeJPigZro3lwotaD/N0kwCOTzmoMmB2wN31izvyprSyMyw
         v+clGE+WfTunM4If4rcqAGc1CLf9N/J0BpYNVjtb9vagRvJCrBlgQGPUZHpOUVewYpu6
         5gEiE0e1f2NyZWriLDf9gmy9Fp9W8E1Vg3fOBhKJTmD5A50g7ogyojVR0/CwHNOG+uvr
         sUU/upIyAhqGYbI0svwm0yFGnRw5HjL8CjWwReLzv8ZmAxRzLU+HLOBN1JhhsglVYeUk
         ZuvHZgHr61hxkd+sR66A98WveG8VtbOt9Z6gRkjEbcBf8fsqXH8vinm4zMHYdUUuSC7M
         EnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650577; x=1784255377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/Wt9nwIkWLRPZshqrH2chvmAQIMoCZXZuZQFMmUS0Y=;
        b=Bd/erMEw0Vr6OumsJTJS4QclhfCxKlNGUlKedbQX0YMkoVDUQrMzYQ6mQaaYdNeTVx
         FxEDETiA68ydkKeU1cCiJtkI3eLKbbz3vdBrg8nMRQ96WvMXejZsl5qPjz0BWhC1rDAk
         PhFEU1gYxtIQdty/WlLW/rTJjxc4xWoXZmJkkw/1uyDyMaJWYa3El9p1h8aENWuRkiAi
         V0O39n5BeoOhV1zqb2PzCF0e+M0jbHUbBdfwH2qnN18ka7iJGtXSqsvsWOH0Pw5d1six
         LRqG+iQxZ77ZIGNNFDoJ6xOvsdE19yZR8h8NWBgHxCE0vWhq7/do/lv9iJXsECjQiiMA
         ysPw==
X-Forwarded-Encrypted: i=1; AHgh+RqQQpLLX1U5Rxl0syNL9hb/v5RVKmmJpYNfTAJbofSHOt916VXTCBedc/9ui6lC4sjfwJS0fXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynF3XDPk2kEjD0/Vlu1dxbu9Z+86C7S5VoLDWEG//vcdCC3je7
	yJ+5Gzpg/BWVzMfHGYqTQAc9shbaqX27uX6kfv5RGcN3Xqh6YshviXAG
X-Gm-Gg: AfdE7cn/hEBOA489IqQdxsWWavheOdBhENzZJ7cKGbrOSpeY7dO/YWR0+LQcLKdR9Hc
	ls3RAVweltipKOzmfjM/irFLQd3IjQ41SHo7omgt2YF9M9snmq2CPjb0fHzNkrnLybKmx3tiMgv
	2cUpaTuQNDXI/trZzMa5ey0pYGbMvAMDACB3xPMbNAXPBDknLfitGLVp4xR2yJ6jLVraMv7aa0q
	zKDEGY1OTi7fOyTHfxoHZtnd/5B/ib6FRB9SNxRyoRmNqavNYHERha663lgjPHw6f0BBXaQTV1E
	Ah1rlXXF8cYLdP9ZB9SLMueHO25PyzytRzstU/hjOsI6wP1653KEvCwDpojsNCItmv3S3Y1+fZu
	maufoz6JIBeHaPut6GomYsxL+miT9COd/KLdjkFuQW8byoBIjAKSbhhrSOsJsSzOrry3O6wYF9X
	vdYKfYZ2L2TfD26mvcgMSE0I4I9BgTjKhy5wzFs5d9WwDRa2jJ0Rn0R3MTxKtJIDZOHgsGAUC3A
	j0QdjnAnpkmZW8DadxP5aGflQtBVqAR
X-Received: by 2002:a05:622a:4308:b0:51c:a2ca:3fc0 with SMTP id d75a77b69052e-51ca2ca5e00mr32009521cf.23.1783650577094;
        Thu, 09 Jul 2026 19:29:37 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b4fsm6951101cf.31.2026.07.09.19.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:29:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Justin Tee <justin.tee@broadcom.com>
Cc: Paul Ely <paul.ely@broadcom.com>,
	James Smart <jsmart2021@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] scsi: lpfc: bound EDC descriptor TLV walk
Date: Thu,  9 Jul 2026 22:29:30 -0400
Message-ID: <20260710022932.3741311-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

An adjacent Fibre Channel fabric peer or device can crash an LPFC host
with a malformed EDC ELS frame. lpfc_els_rcv_edc() trusts the EDC
descriptor-list length from the received frame without checking that it
fits in the actual ELS payload, so a short frame with an oversized
descriptor-list length walks the TLV list past the receive buffer and
trips a KASAN slab-out-of-bounds read in the ELS receive path.

Patch 1 passes the received payload length into lpfc_els_rcv_edc(),
rejects truncated EDC headers and descriptor lists larger than the
payload, and avoids logging a third payload word unless it is present.
Patch 2 adds same-translation-unit KUnit/KASAN coverage: a benign EDC
frame that must still parse and the malformed frame that must now be
rejected.

Reproduced with the KUnit/KASAN test on f5459048c38a: stock trips
BUG: KASAN: slab-out-of-bounds in lpfc_els_rcv_edc after the benign
control passes; patched rejects the frame and both cases pass.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  scsi: lpfc: bound EDC descriptor list by payload length
  scsi: lpfc: add KUnit coverage for EDC descriptor bounds

 drivers/scsi/Kconfig         |   7 ++
 drivers/scsi/lpfc/lpfc_els.c | 195 ++++++++++++++++++++++++++++++++---
 2 files changed, 189 insertions(+), 13 deletions(-)

--
2.53.0
