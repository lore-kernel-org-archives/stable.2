Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.22.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150907;
	b=CZnTeVch35KisnGlS6HjY+9Qw/nUEAgN2ABBQt+nt54of4DNkkLQV4oGkLQuKvpCk+bF
	 1LDRkwEcFAo4fYGiVsfVt3I67i35BirBkU+TCawuRftR9Q5QUtpS7O93HfMf/SFNJBJBD
	 keKmicmjBmr2J0b5LU1eiJP58ychJTrJM74tNMzuf06ZSGjOMXqppwelq/8hLdtD2rfiz
	 /9WmnOjsMOril7IHwTSSVIyVJ7wA0xRFDkTgSwdS59Wy64aKKzyQIrbfVDCqzfZYG3OGu
	 GR6M71gFTfPahJDF/IaTQFAm03Dsw2ZucJeUpDe/Lc68Qkhtb1bsh4bYDv1z5J4d4Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150907;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=JG2GQZF9OFBITES8znzV7SWl9mp648C4uR4ZeUQZ65A=;
	b=z8MWyxCJBIQyReNvvZHq0muRdDsJ7D8NT90mRsu6vq927ib17LGnN0UXzUlLB7PsCtHg
	 pF9GCRb9SeDB8Af4T9uo5fFraTYz3Nh0AnXJvqjU5HJHPIxjRAzuH1H9gIQuaAhHtKR3k
	 chi3V18VbAS+CWp8MKe0CG4wWlr7ajAVjjwSTILkkVHNJu6Y6NrAMU6QewR/G1qp2XZIo
	 x3nC82FzyRaNIWWtfMxCp/evhUEkmLLDYhUqjD25esy0gj1LpM6ivFAjC4yIAxkVgBqCO
	 tIhJmnxcv8Lt3v5SG/YOCUXHPNizx0Jd1xZhpGZ/wXSI+C2+zvu/HTG1LGlFsa1/eXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=UaUzvxHV;
	arc=none smtp.remote-ip=54.207.22.56
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF4606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 05:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2CF4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=UaUzvxHV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795150897;
	bh=JG2GQZF9OFBITES8znzV7SWl9mp648C4uR4ZeUQZ65A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UaUzvxHVgb2xgFhxHZo+OMrfUwhYBR8Ad4h69lB5MVnio8v81h3UZaD4oBJWnagMs
	 GIF2y/sC8rApXv8ub2SJPqIxgB5Sx8LOCgEqF7VgF/ii2ZY/1WGi06TslBeqT/Vy8l
	 1KqW7Du957Dq90cQxyZAU1OAUYI8hZfC1vaYmdJc=
X-QQ-mid: esmtpsz17t1795150893t7e35b75a
X-QQ-Originating-IP: m6YYTV9TGyutVeOW9D230iP91GhygKncnbNmAIWOIuI=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Nov 2026 13:01:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15613825989066999136
From: Xue Haolin <xuehaolin@uniontech.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: fix race between sctp_sendmsg free path and peeloff
Date: Fri, 20 Nov 2026 13:01:08 +0800
Message-Id: <20261120050108.426545-1-xuehaolin@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N3I7nP72NaLrUPgr+vzlosjhGaYCMXOpavFk63b6wgQBtHS97N94ceUs
	tL3HhD2kYiRDlIfnCfdPIc0Ak6ouQ2zTgorqOaAF+5EvYitEevsRsekSQfPdb7oc2OXOals
	PNO36jdwA3U9jEN7V2lTr5jSLsvFJyH24n5lrqmCoNPueiSqiNjtw4uhKiaG1qKvVIlI6Cz
	BipumiMvnANunOZxwE8H8z3Uu+uJJc3d84S3+caD+xxl3dizQKyRSbH/2zpSf4G2ANRIAme
	5tW5A4doN6xLWypwNovklCdEi6nPp60kNzKJXAhs2b7qxPcYXPWeVADZtj04OUWuuFQcziq
	1aqkFI1kJh8q//pBuWhNz/giEvDW6EvYsDgDmphUbIehHK5iThGZbF3LVlFCZ+yjZo2gW1X
	wzBJJ8oebPSfa8WLCBKgjpYSvLdHSH3NrTlC4yId71guuMZzdy62WlaF+HA8sniTRz57/PO
	vpro0LM7r1EZrT8VgRBJMV8R3g/fe/Hwz/CX33MVcXcgBJCdALUEVbDNbHbqpPNvn2Fznha
	jHIiR+GEgcZSQ75CVlkCgvQ5crfKwWG27Xtx1PqdKL1FwPvLlIinlgloe9OT95WnD6l1l82
	vkVZY5OsJ0O/GugA6oOc4xa62TOhbpdEIlBctX+of1GqTAWYdtKuswzCc/ZmTR4dBRlLLW2
	YjMBrxfCBN/O8s44R1+RNsoe52SDqYuJ1MWrdjrAezy+CvLuVFLVws436N1C+UbOihWXQZH
	cchtpIapNgu5rDeNEIRg95IH5kTLc9TB0IEsOYNGwEvWuRN05K33Zzns9GE1f/HmwwdgoRg
	3vWEACf80fux5XUSELP+IBxQsuqf3bxR4H1kA2v3lkoMYl6QWsUxgo9AN+dIctjVEOhnAzx
	3byciFYXkWTOruPtZGr8e0G3vRTqw1KbPedzvyADRCdxiwQytuc5+eYPLq3cJAalYYT+b7h
	FZOy3EYWxG2S6V4JXZsDWe4/a9NBiNAevk5U7prGvPkvQgIPR9KX3WeZtQ3K5QVsHk8J5aW
	4/psAdUyFL/b1zOZX77CIXhmE8RH7lNKQeHOwqlA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Haolin Xue <xuehaolin@uniontech.com>

sctp_sendmsg_to_asoc() may release the socket lock while waiting for
sndbuf space (sctp_wait_for_sndbuf) or connection establishment
(sctp_wait_for_connect).  During this window, another thread can peel
off the association to a new socket via getsockopt(SCTP_SOCKOPT_PEELOFF),
which migrates the association by setting asoc->base.sk to the new
socket and moving it to the new endpoint's association list.

When the waiting thread resumes, sctp_wait_for_sndbuf() detects the
migration (sk != asoc->base.sk) and returns -EPIPE.  However,
sctp_sendmsg() still calls sctp_association_free() on the migrated
association when err < 0 && err != -ESRCH && new.  This frees an
association that is now owned by the new socket, leading to a
use-after-free or double-free.

The connect-wait variant was fixed in commit f14fe6395a8b ("sctp: fix
race between sctp_wait_for_connect and peeloff") by adding the same
sk != asoc->base.sk check that sctp_wait_for_sndbuf already has.  This
patch applies the analogous fix on the caller side: guard the
sctp_association_free() call with asoc->base.sk == sk, and hold an
extra reference across the guard check so the association memory
remains valid even if the new socket is closed concurrently.

Note that the sndbuf variant of this window predates the connect
variant: the unguarded sctp_association_free() in the sendmsg error
path existed before the sctp_sendmsg_to_asoc() refactor, and the
sctp_wait_for_sndbuf() sk revalidation check was already present in
v4.14.  The Fixes tag targets the refactor commit because that is
where the current code structure (sendmsg calling sendmsg_to_asoc
which sleeps) was introduced; earlier kernels have the same race in
a slightly different code layout.

Discovered by manual code inspection, following the public report of
the SCTP local privilege escalation (Xint "NGINX2Root", 2026-11-18).
The issue was not triggered here and the fix has not been tested
against a reproducer; compile-tested only (make M=net/sctp).

Fixes: f84af33138a8 ("sctp: factor out sctp_sendmsg_to_asoc from sctp_sendmsg")
Cc: stable@vger.kernel.org
Signed-off-by: Haolin Xue <xuehaolin@uniontech.com>
---
 net/sctp/socket.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index b5a57f61ee6d..0039c54a55d6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2082,10 +2082,29 @@ static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
 	/* Update snd_info with the asoc */
 	sctp_sendmsg_update_sinfo(asoc, sinfo, &cmsgs);
 
-	/* Send msg to the asoc */
+	/* Send msg to the asoc.
+	 * Hold an extra reference for newly created associations so the
+	 * memory stays alive across the migration check below; see comment.
+	 */
+	if (new)
+		sctp_association_hold(asoc);
 	err = sctp_sendmsg_to_asoc(asoc, msg, msg_len, transport, sinfo);
-	if (err < 0 && err != -ESRCH && new)
-		sctp_association_free(asoc);
+	if (err < 0 && err != -ESRCH && new) {
+		/* sctp_sendmsg_to_asoc() may have released the socket lock
+		 * while waiting for sndbuf or connect, during which the newly
+		 * created association could have been peeled off to another
+		 * socket.  The hold above keeps the association memory alive
+		 * across this check.  If the association was migrated,
+		 * asoc->base.sk no longer matches @sk and the association is
+		 * now owned by the new socket; freeing it here would leave
+		 * the new socket referencing freed memory (use-after-free /
+		 * double-free).
+		 */
+		if (asoc->base.sk == sk)
+			sctp_association_free(asoc);
+	}
+	if (new)
+		sctp_association_put(asoc);
 
 out_unlock:
 	release_sock(sk);
-- 
2.43.0

