Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819258;
	b=oKvWMuhQOD2kcVzqYCNiy5On5T9AGj6/fVPPHUZUunVes/ekQGvCbsTHIKM3hLaQMgPB
	 MxS3P/y+dQK1hvPXD4iCSrjNgESH206U69/ED9Pg8I+cy+FQlLZrPn53rkVBX7yfrj65X
	 hvg2I8vOuLENIPhi8dLb4xT/LDqA2GHnMN19xHVI5cdUqP0qClZRx+Buju+pNVQ+uw/jE
	 MidID3YaD7mB0aBUPCrMA06c2B+53CE1hJNKU1JLEwhNEy+lHgXAX21p3AgPy4pL3xmYh
	 NsUctWoBbHa3haScThfZirZeXNp6q9JiXH6F8L5N9uDQVNppkTqu5TMC+Ab/opKA6lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819258;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FZbvUKYBX+kOP8noIgkTTxEpZ4snzWmK0NaFTienGdU=;
	b=rfStY+7DkySo/YIvOyOSPRJEZwy9fsiHJ1qZlI1Q2SABTo6yAfM2Zd6FTcs5jXxLtFpr
	 /1IOq4gulMDiTd3DDN4q7B2TQ+dldi1Fg2T816/z78TrSTxHrDJOWmzsSHRx7ZeQvx9BF
	 IOLqrzB/5Sld23yVwmW/1eTO8fMdiOi8OMmBXyrgpDPxzS6Tjd9Zt6zlRSw6YS96fcUSk
	 LJCusKjw2TVUoqDWosZiuTVMyvR+xkCJw2kS/EqDRvVF5qVq90xb/YYhj61ebVVsapkER
	 guLRPjegcV0D/X5lJSw6ZIVv7z2VcgShqieWnKAwhlGn6S82twEVwrd5DS/e9sUOqLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VboQMoCh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466D606A33B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VboQMoCh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845881F00A16;
	Wed,  4 Nov 2026 19:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819257;
	bh=FZbvUKYBX+kOP8noIgkTTxEpZ4snzWmK0NaFTienGdU=;
	h=Subject:To:Cc:From:Date;
	b=VboQMoChsJbkPn20Q4lSdWXViJdBc5sxyNobMyn/3eocQzSS5Zs1em3a10zrCYJCc
	 j6mrAj9Kn/EXTM8qolOLoo3VuhVYqOcdAGUebqMXY8fQ7Inq0ureT7uckdRimlw5G+
	 YixItY5nHivBt63I1jWNCyean2ODC5OzD9U1Uy/4=
Subject: FAILED: patch "[PATCH] SUNRPC: trace an accepted transport before publishing it" failed to apply to 5.10-stable tree
To: zhilinz@nebusec.ai,cel@kernel.org,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:07:36 -0500
Message-ID: <2026110436-footnote-extrovert-e489@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 06f90cf104fc21ee01e7ef1eb80e092173089b9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110436-footnote-extrovert-e489@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06f90cf104fc21ee01e7ef1eb80e092173089b9f Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Sat, 12 Sep 2026 21:56:09 +0800
Subject: [PATCH] SUNRPC: trace an accepted transport before publishing it

svc_handle_xprt() publishes a newly accepted transport before tracing
it. svc_add_new_temp_xprt() places the transport on sv_tempsocks and
clears XPT_BUSY, so another nfsd thread can dequeue it at once. If the
peer has already closed the connection, that thread runs
svc_delete_xprt(), which drops the list reference, the only reference
the new transport holds. trace_svc_xprt_accept() then reads the
transport's addresses and network namespace from freed memory.

Before publication the accepting thread owns the transport
exclusively: XPT_BUSY is still set from svc_xprt_init() and the
transport is on no list. Emit the tracepoint there.

Fixes: 11bbb0f76e99 ("SUNRPC: Trace a few more generic svc_xprt events")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Link: https://patch.msgid.link/d15495bff2247e3f9d4f9ef36df8e246a3898380.1789220778.git.zhilinz@nebusec.ai
[ cel: trace before publication instead of taking an extra reference ]
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d5634dd6d6cc..5e210bc68422 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -861,8 +861,8 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		newxpt = xprt->xpt_ops->xpo_accept(xprt);
 		if (newxpt) {
 			newxpt->xpt_cred = get_cred(xprt->xpt_cred);
-			svc_add_new_temp_xprt(serv, newxpt);
 			trace_svc_xprt_accept(newxpt, serv->sv_name);
+			svc_add_new_temp_xprt(serv, newxpt);
 		} else {
 			module_put(xprt->xpt_class->xcl_owner);
 		}

