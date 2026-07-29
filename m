Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B9442B2F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332121; cv=none; b=r3cBPNeqH9mfS7ugzZjAWgAPRNg54pd8aAYRvrfhA1ECOI0RX0+ut7RnkGuV7QQF896bQgPcHrCl8KYiL7Jf26LP9yP1vRwztAZDCTJklaoExw2jMIDI+HjOuk6iYPNwUW+4mlF7IaCaZIZvYmgj1P2znKRGmezi3KwbJJ1DK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332121; c=relaxed/simple;
	bh=FlLnahipf5FahU5YGcwk5e7T4ZS0tnYyYHPxq9Vli/Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b4OGNiXgN4Yom+R9YtwwbzLmwbKtNOp6J+S2yCzVgSFHSV2nwn2+ne4qCyAdZ7rbV16Dok+2MJB4Tr+1Zc1emxrKjA0wsZNJ9R3geuUn/iAe9fno/QoD+YX9m29hJePxfCjVWfIt3FSffoLEZC/bhHSAEP2GeMTAVFbaomNsZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pg2B7cMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pg2B7cMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A7B1F000E9;
	Wed, 29 Jul 2026 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332119;
	bh=e7WGitYgUTeZDsAEx2acK1Y5CqKfpR1bhASQmi1v9LY=;
	h=Subject:To:Cc:From:Date;
	b=Pg2B7cMSu7u9BGRXKKOpt+87WPEnlnIEXdTyUfkYlx8Rcs7oUnPtW8lj0cfMfRZm9
	 E1SqD45z4Bb8rcSJLV8D74/FtGTylv6g2UasGlH434mBYuQORT1606nquLscYGH3WS
	 LuVzpkM5Geen4Uqmsf3M/+coVUufF7+mbI3dB3qc=
Subject: FAILED: patch "[PATCH] mptcp: only set DATA_FIN when a mapping is present" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,kuba@kernel.org,matttbe@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:35:05 +0200
Message-ID: <2026072905-municipal-wasp-9221@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b2ff91b752b0d85e8815e7f44fd85205c4268094
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072905-municipal-wasp-9221@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2ff91b752b0d85e8815e7f44fd85205c4268094 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 9 Jul 2026 15:19:25 -0400
Subject: [PATCH] mptcp: only set DATA_FIN when a mapping is present

mptcp_get_options() clears only the status group of struct
mptcp_options_received; data_seq, subflow_seq and data_len are filled in
by mptcp_parse_option() exclusively inside the DSS mapping block, which
runs only when the DSS M (mapping present) bit is set.

A peer can send a DSS option with the DATA_FIN flag set but the mapping
bit clear. The parser then records mp_opt->data_fin while leaving
data_len and data_seq uninitialized. For a zero-length segment
mptcp_incoming_options() evaluates

	if (mp_opt.data_fin && mp_opt.data_len == 1 &&
	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))

which reads the uninitialized data_len and data_seq; KMSAN reports an
uninit-value in mptcp_incoming_options(). The stale data_seq can also be
fed into the receive-side DATA_FIN sequence tracking.

Record the DATA_FIN flag only when the DSS option carries a mapping, so
data_fin is never set without data_seq and data_len also being present.
data_fin is part of the status group that mptcp_get_options() clears up
front, so on the no-map path it stays zero and the zero-length DATA_FIN
branch is simply skipped. A DATA_FIN is always transmitted together with
a mapping (mptcp_write_data_fin() sets use_map along with data_seq and
data_len), so legitimate DATA_FIN handling is unaffected.

Move the pr_debug() that logs the parsed DSS flags below the mapping
block, so it reports the final data_fin value instead of the stale one
it would otherwise print before the assignment.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260709191925.2811195-1-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dff3fd5d3b55..1b74ca5b6a59 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -157,17 +157,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr++;
 
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
-			 mp_opt->data_fin, mp_opt->dsn64,
-			 mp_opt->use_map, mp_opt->ack64,
-			 mp_opt->use_ack);
-
 		expected_opsize = TCPOLEN_MPTCP_DSS_BASE;
 
 		if (mp_opt->use_ack) {
@@ -178,12 +172,18 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}
 
 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
 		}
 
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
+			 mp_opt->data_fin, mp_opt->dsn64,
+			 mp_opt->use_map, mp_opt->ack64,
+			 mp_opt->use_ack);
+
 		/* Always parse any csum presence combination, we will enforce
 		 * RFC 8684 Section 3.3.0 checks later in subflow_data_ready
 		 */

