Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204221;
	b=egBdcmPSTPyFobHWw2S/CJAro8ATxnJ2//7ycYJL8l4HNFnSSoGdxGygAp09zAx/I7gR
	 XPAxLlY3XFmxKah7QlZDmfLkI+JELJkgSh/n+QXUgimtbTMwcsTz5G+4iQg97DauJxHMs
	 ptLwwnFVW2mYC6bZBu9vlDvnNKvIdrjCCzVbr4lYhM12pLz/UUJQxQPk22zZZXBJQID/1
	 ZdjAnd26JDmi1UTo1t6WOpAyGBUkP+7l1QqfIMChmQaXgG3pkgwaHSxSfYGy01o2/2eIl
	 0Q5ZhvNBQzT4+C+hGPVCAuTakdq1JrZ0jUjPTmFpFXnaTfTOMRQ+WhTpXJmftCx1GBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0gKK6+kyEdy4ObANSuJOnAcVDDrpLTxw4rxdFQZ9nDc=;
	b=FZbND7TQGCmMjvDqaG7JOJ0kUf3tkbsAOPDBLuYdIXQVXE+xLUhwBj52snBoeiI9iu42
	 m/BeaB4TQ9SByDtQdYHuMcooqB5lTmYwvoHQGbuXSbLDOcVLWCGEqgA76S2spTa1kPmjB
	 wu3XOJqJ5YceP+6jJ9BJikaWvmXq6qnMYRhSbWOH/XAU2bNH4whiYgbtcLfj+Kt7D9ueI
	 pdPuf48IymQjEghX/e+Eqnvrr9qMpY53SlzEMOPCrwvQWCzhcCrT1CvJb6FEtwiMjMnR+
	 583uXCxiDShBByDFOLbxTIoDqOvbpYfA8LhBtF9eg1hXJSzUH189WlH880d/ng0HTwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ibqE0/JP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7E606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibqE0/JP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096FD1F01825;
	Wed, 28 Oct 2026 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204220;
	bh=0gKK6+kyEdy4ObANSuJOnAcVDDrpLTxw4rxdFQZ9nDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ibqE0/JPcBS0Klct7XJsTVTyq427HU2F4Gt65uASd1XJlEkkOuvpw835QzWQ6dcDV
	 hccTqLNWMz4he778kwSCBoJbCNH1qNdOieud3TvnSV1rpGDXzs6sa500KWLt0W5+er
	 Qzd31I/T9Xx4UkyOmR940siZEezlaU+Jwsa/Ky/QkYLIJ1cjvpK2yjCtun3mV+41Fv
	 4lSvyRCJggvbHN9qgJAUbYq87AEfiwk2t6giPXtIsSXtEDyu56TyJU38UTAkS8q/CT
	 9FhSSHm4m0DR+IAMTuOpk5rSwksiRZQf4pF/0XQtl0y625EecYHSRG9enKFgNjIOWp
	 y69X5lpLYyl5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Juanlu Herrero <juanlu@fastmail.com>,
	Anand Natarajan <anand@meta.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] io_uring/poll: avoid retry wakeup loss when dropping ownership
Date: Wed, 28 Oct 2026 12:16:58 -0400
Message-ID: <20261028161609.942683-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102833-buffing-shone-0fb5@gregkh>
References: <2026102833-buffing-shone-0fb5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Juanlu Herrero <juanlu@fastmail.com>

[ Upstream commit 937d38dcacd675dc0572d6c9b6743960df3128ed ]

If a wakeup sets IO_POLL_RETRY_FLAG between the owning task consuming
the existing instance of IO_POLL_RETRY_FLAG and the loop check
of io_poll_check_events(), then we stall on processing the request
until an unrelated wakeup comes along.

Using atomic_cmpxchg instead of atomic_sub_return to guarantee both the
count v and poll_refs are 0 and no wake-ups are missed.

Cc: stable@vger.kernel.org
Fixes: a26a35e9019f ("io_uring: make poll refs more robust")
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
Assisted-by: LLM
Suggested-by: Anand Natarajan <anand@meta.com>
Link: https://patch.msgid.link/20261013-pu-cmpxchg-v1-1-4ddc10fd8a03@fastmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ sashal: Relocated the change to io_poll_check_events() in the monolithic io_uring implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8d5791d8f4031..a87b24c77c0ee 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5690,8 +5690,8 @@ static int io_poll_check_events(struct io_kiocb *req)
 		 * Release all references, retry if someone tried to restart
 		 * task_work while we were executing it.
 		 */
-	} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs) &
-					IO_POLL_REF_MASK);
+		v &= IO_POLL_REF_MASK;
+	} while (atomic_cmpxchg(&req->poll_refs, v, 0) != v);
 
 	return 1;
 }
-- 
2.53.0

