Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106337F8A5;
	Sat, 19 Sep 2026 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846573; cv=none; b=Zgqr4ZDle7Fzc4jy6cQAdkY/SXLMpQ3nOMIX94B42/WAKg4MRJk90DIrsGi35V7kpijfYnQ+ACpjPSPnrWj1sDGpzIyUC9KpglkItHu+FHneq4IYMYSFfZAeUoVF/+G3B6OY594ENlSsbSulfO+ZkzuKcn/NekzvDJRgLqLwwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846573; c=relaxed/simple;
	bh=TfzeQIK27t9eTMvzel3SPQcHoJrIpYJUvNvHcZjvPX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbqnDuiWj0xaV+6J/9ha3JQOtaAvEnSM81na4C9p1CAevEd/gUAA2p5W3r9kOWxHco5S/csdCXIJ/HPUCh+ONUC/AMe3/XTloIOBXXI5X6WFOuvI27lsFCcRf+1NTGVAGkSRpZHZoEV5z2SdR/f0bWX+svXOg8sXP/qJr1zJwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwagS/xv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwagS/xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19AC1F00893;
	Sat, 19 Sep 2026 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789846572;
	bh=/dX5RDRjuPPB5D4Lt8fvfZHMKwejWXrmXHGsU3a20XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WwagS/xvImXe2SocOgT6DkW1pafutUR0vXfX/UyyN80FuwI26YKk4YmKodBGR0lmn
	 qHKg99hNz7WZjghe7zxfXr6oqouJBopQ3RRTmR1NZYbxkSdRK8zmGqOtRXuv2Ripbk
	 vfBgVNITO8YEAb15JKI96N3+IWQzgVCdTe9HX682UB9L22PY9VhsQu8kJECXEynbR1
	 cuO8rsxFO0YLPc3WvYrEqdztWM2LnBCavhz3GZmQaexcBI56CCnWGNdMSKE22z2Mmz
	 M0mUal7G5rS+cuvwTc1AS6B/8TCTFrE+1TSDTRHwwuTj5gsRB/Cc0bT5A79kHqV3dz
	 TpXk4iRLqnOqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.2.y 4/4] mptcp: fix bad accounting in __mptcp_subflow_push_pending()
Date: Sat, 19 Sep 2026 21:35:46 +0200
Message-ID: <20260919193541.1915297-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193541.1915297-6-matttbe@kernel.org>
References: <20260919193541.1915297-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=matttbe@kernel.org; h=from:subject; bh=CBGyH42FD8cIrT1KBwusD3qZxSa0CQyV0XC8tYc+c4Q=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPRH6ris2Xex2c82BPblHPxeWRDpffhcsNYf99dK4p pJFN9be7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIWQ3D/7AtdfvCHVP0WYX4 vuTMTSjfUz+va9KBneW/ktuWslr9msTwz6TNtaL+afK3i8n3SrdqSfjlfSuZtG3qHPs975ne/dn 8mwcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit f3ef03357396d4b147d8e76c75fb612c2f264ffc upstream.

If __subflow_push_pending() errors out we should avoid updating the
copied byte counters, to avoid mismatch push call later on.

Fixes: 0fa1b3783a17 ("mptcp: use get_send wrapper")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-3-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99fd31036222..49c46498af96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1778,7 +1778,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
-- 
2.55.0

