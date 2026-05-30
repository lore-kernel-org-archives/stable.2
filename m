Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E63B27D4
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150654; cv=none; b=InWBZqpKQ7jOSQ5aGPIsli90E48psxSDq+M2aZhQcZeK0wjYSyKR1ehZWMA8PokJXz+hJCHIvHbcsNuTMW9aTY/4SOby9qUSKeza+il5AKHplSUiQQxWmfBtrkCK2suFWnJ7rpMP6oUp+jZ9/au9szrqbzs2nP96FWi+PemoX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150654; c=relaxed/simple;
	bh=Sed0j1KCJyCV309c3szpVoUX/STdFCYN1Mw8kx1mIAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVXCDw9h4Hw7yO6yntw22aoO+E/kSCh9MCet97yQOAB0TD1kPGbFh6H3GZ383ytB9hF8k0nnUa8v4ucuWqG3HrczjtJ+fAyuimDv+cax9X3VEpOpFv2DAwXsSOR9ANQjGWcqBcKh+1ZQKOxQ4VauDwv/ZWqxhZhQwaTIDzCxI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbZxJFjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbZxJFjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3411F00893;
	Sat, 30 May 2026 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150653;
	bh=zt6akBRZgTTJooW+P/Qc0crDzJWEs1eCs9VNsjbY/5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KbZxJFjJLTZOIkEf2/dbXfX5zz5z9UgWGHEaXypVtgThlTIokWjQxIVMC1tBni1iU
	 MeOTUfrkugP6EzBNXsuaavzCv+3ECQrZ2o7FIkRAGY/2EhRcf43XJJTXuv4x6EBpQu
	 awu31RtHTNwoWvSDw4U7SQSDL5yhsSBBSGziBPInJU743LdJOFGZsZaaxHq2aEPLE3
	 P3BRwq86gD8F7im1PZkZ8U5f2by3q0K+6kZqCJNViLsxQsTX7G4wx8/3MSNOnCimGl
	 NW5pdQC44//bQQeDPlAtp3mES8uXmcEPEvGucKRDLYnbygn7AxeM0vKE+J35M/oc+s
	 TA8yMm/bpNnmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] mptcp: use plain bool instead of custom binary enum
Date: Sat, 30 May 2026 10:17:26 -0400
Message-ID: <20260530141728.2398427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052851-deskbound-cardigan-c96b@gregkh>
References: <2026052851-deskbound-cardigan-c96b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit f1f26512a9bf18f7a4c0d59df113a49f39d7d4b6 ]

The 'data_avail' subflow field is already used as plain boolean,
drop the custom binary enum type and switch to bool.

No functional changed intended.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231023-send-net-next-20231023-2-v1-3-9dc60939d371@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0981f90e1a05 ("mptcp: reset rcv wnd on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h |  7 +------
 net/mptcp/subflow.c  | 12 ++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2a33452715597..04710362fff4c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -451,11 +451,6 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
 	return (struct mptcp_subflow_request_sock *)rsk;
 }
 
-enum mptcp_data_avail {
-	MPTCP_SUBFLOW_NODATA,
-	MPTCP_SUBFLOW_DATA_AVAIL,
-};
-
 struct mptcp_delegated_action {
 	struct napi_struct napi;
 	struct list_head head;
@@ -513,7 +508,7 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		__unused : 9;
-	enum mptcp_data_avail data_avail;
+	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	u32	remote_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f2fc735d8b618..b8a8718573e62 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1303,7 +1303,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	struct sk_buff *skb;
 
 	if (!skb_peek(&ssk->sk_receive_queue))
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+		WRITE_ONCE(subflow->data_avail, false);
 	if (subflow->data_avail)
 		return true;
 
@@ -1337,7 +1337,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			continue;
 		}
 
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+		WRITE_ONCE(subflow->data_avail, true);
 		break;
 	}
 	return true;
@@ -1358,7 +1358,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
-			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+			WRITE_ONCE(subflow->data_avail, true);
 			return true;
 		}
 
@@ -1375,7 +1375,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
-			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
 	}
@@ -1385,7 +1385,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
-	WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+	WRITE_ONCE(subflow->data_avail, true);
 	return true;
 }
 
@@ -1397,7 +1397,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 	if (subflow->map_valid &&
 	    mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len) {
 		subflow->map_valid = 0;
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+		WRITE_ONCE(subflow->data_avail, false);
 
 		pr_debug("Done with mapping: seq=%u data_len=%u\n",
 			 subflow->map_subflow_seq,
-- 
2.53.0

