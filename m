Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710593;
	b=amJUES7ssIGxJ+lykbCevGnjFjyHYlT9ZmBvnWvfa+b6zlMjtk2YC8i6s0Fyl4aH03Jk
	 T1zp6pMDVeghlwLSzOkMpLZJwwNweNinSXnVtvsGj6hzlHtuNG5YDTw5s9jVt5XZnb7o1
	 ABPFs57aj8KXlm0npKRMu5iRrRgwmPtSPRxj5g2RYKu8ngu5SFhiP1cp65HTk2WI5oF9G
	 SB/xzHc86dN3ARHwsP1xjeFLaylnvFptyh4TXnVB3Sj+BKXSVCvtlZWM6AKwPZWistZpB
	 7nFmBkMXq35aB6po1g0gKTd23xUhUmLNTmaXDM/Nlvt+wbSzZFrRoPQ5mXPHFFcg/IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/0JpKxWZO9qC/U9TTapdOiREiy+R8toMFxPTxLQoNBA=;
	b=eZeXhjpVh+gvDnVc2zxrGZ6MTgTrkoPg7Pq7VD1RDFMXFJoMn1fM8Ge0IUOlhfPR81Hq
	 3yaBq5ByVZKfG7Y2DEak1O+L1UGDKLcZO/h18CscaxHydVQH7upXW5K1FdKnloR5zbdVl
	 8KBxYb+LEuo0hAQ9nSDyXRbshv79a/6BlHoq4t+r0c1m+pKND5yvoKseSV0CwzPjGPz0r
	 Lc32sh7TTiMGC5JmFQVZMdwdFb+1czRYy683RbEq20lYSHCuZrD96GHaesUntDeVBae04
	 2I4Gkp4SD/S+ALCvJjqcbEBjEHb0n2LbVn+KyO+PdDFfO1greBrL8/dm/OyrGB626Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNnv9I1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276D6606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NNnv9I1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCBF1F000CA;
	Thu, 26 Nov 2026 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710592;
	bh=/0JpKxWZO9qC/U9TTapdOiREiy+R8toMFxPTxLQoNBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NNnv9I1f4+skFp2HPbzG/tlTQGdNkh06YEikWE6OV/LF0aaDwtoU6A9hWlodrZ9OH
	 ZBt7/rRHFxsY9T6clWBIcBo0ShcEWhJeQ/TYQB4bleE036yda+XqwJqcABhu+2QTiZ
	 4rUXzF4xOSeW5/Hzyl4tedunX+YocUgo+P0XuYlWLZODlSiJW+yDX37DdqA/V2DLxv
	 m78Nh0N1bBcbrw0RWW9hn+vVjUL+8HLlYY2GpwwDRGXxuXSPXNUFAZCsHbCRk+zWmS
	 eCTe0EK84eJgSUJjX4nMrBqDglihAPRvF2GkdZb/hp4awLsSr+dR77HJfWjgKUrUfn
	 WR6bdO+GJA7jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	stable <stable@kernel.org>,
	Selvarasu Ganesan <selvarasu.g@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: dwc3: gadget: Issue no-op Start Transfer only for stream endpoints
Date: Thu, 26 Nov 2026 11:29:50 -0500
Message-ID: <20261126162936.2589542-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112536-enjoying-hemlock-1df3@gregkh>
References: <2026112536-enjoying-hemlock-1df3@gregkh>
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit e616d91e02881983e5dadf6980c4aa08123800b3 ]

The function driver may re-enable an endpoint before the End Transfer
command issued on ep disable completes. The no-op Start Transfer issued
on ep enable then fails with "No Resource".

Only stream endpoints need the no-op Start Transfer to initiate a
stream. Other bulk and interrupt endpoints start their transfer when a
request is queued. Skip it for those endpoints, and move it to a helper
to be reused.

Fixes: a97ea994605e ("usb: dwc3: gadget: offset Start Transfer latency for bulk EPs")
Cc: stable <stable@kernel.org>
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/20260227121236.963-1-selvarasu.g@samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/227e97e30d26a017c92d7008a8633c01f955d088.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Moved the no-op Start Transfer into a helper that runs only for stream-capable endpoints, keeping the tree's existing stop-transfer arguments and unconditional restart flag since the flush-bypass logic is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 84 ++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5ea6d0c929db2..ef98d54f11c7d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -651,6 +651,48 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 		bool interrupt);
 
+static int dwc3_gadget_ep_start_noop_transfer(struct dwc3_ep *dep)
+{
+	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_trb		*trb;
+	dma_addr_t		trb_dma;
+	u32			cmd;
+	int			ret;
+
+	memset(&params, 0, sizeof(params));
+	trb = &dep->trb_pool[0];
+	trb_dma = dwc3_trb_dma_offset(dep, trb);
+
+	params.param0 = upper_32_bits(trb_dma);
+	params.param1 = lower_32_bits(trb_dma);
+
+	cmd = DWC3_DEPCMD_STARTTRANSFER;
+
+	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * For streams, at start, there maybe a race where the host primes the
+	 * endpoint before the function driver queues a request to initiate a
+	 * stream. In that case, the controller will not see the prime to
+	 * generate the ERDY and start stream. To workaround this, issue a
+	 * no-op TRB as normal, but end it immediately. As a result, when the
+	 * function driver queues the request, the next START_TRANSFER command
+	 * will cause the controller to generate an ERDY to initiate the
+	 * stream.
+	 */
+	dwc3_stop_active_transfer(dep, true, true);
+
+	/*
+	 * All stream eps will reinitiate stream on NoStream rejection until we
+	 * can determine that the host can prime after the first transfer.
+	 */
+	dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
+
+	return 0;
+}
+
 /**
  * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
@@ -711,48 +753,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
-			usb_endpoint_xfer_int(desc)) {
-		struct dwc3_gadget_ep_cmd_params params;
-		struct dwc3_trb	*trb;
-		dma_addr_t trb_dma;
-		u32 cmd;
-
-		memset(&params, 0, sizeof(params));
-		trb = &dep->trb_pool[0];
-		trb_dma = dwc3_trb_dma_offset(dep, trb);
-
-		params.param0 = upper_32_bits(trb_dma);
-		params.param1 = lower_32_bits(trb_dma);
-
-		cmd = DWC3_DEPCMD_STARTTRANSFER;
-
-		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	if (dep->stream_capable) {
+		ret = dwc3_gadget_ep_start_noop_transfer(dep);
 		if (ret < 0)
 			return ret;
-
-		if (dep->stream_capable) {
-			/*
-			 * For streams, at start, there maybe a race where the
-			 * host primes the endpoint before the function driver
-			 * queues a request to initiate a stream. In that case,
-			 * the controller will not see the prime to generate the
-			 * ERDY and start stream. To workaround this, issue a
-			 * no-op TRB as normal, but end it immediately. As a
-			 * result, when the function driver queues the request,
-			 * the next START_TRANSFER command will cause the
-			 * controller to generate an ERDY to initiate the
-			 * stream.
-			 */
-			dwc3_stop_active_transfer(dep, true, true);
-
-			/*
-			 * All stream eps will reinitiate stream on NoStream
-			 * rejection until we can determine that the host can
-			 * prime after the first transfer.
-			 */
-			dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
-		}
 	}
 
 out:
-- 
2.53.0

