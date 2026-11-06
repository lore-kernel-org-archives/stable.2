Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952063;
	b=cK3bEHPn9hTkmOEIlE1Vym8TZrXSilHw+g1Tfs/2akuBJ1d1U+Zv4vLBmuvfy+lsyCZG
	 jC5DCw4Ijk3Elj0xRRuyLNWJaiZjYbtvqHRJ793UFeScKLsVGiSn3viFfwH2lyxvqmKKT
	 pCccHoe07yZ80ZEswuU/EvwcZG441B0N1kH7Kag+5Q7ajb7h4vx+bTF1Zisn4R1EVIttv
	 cLUdcZscaIAcyD/BoBm21EYzYPVg2osomWkqv2WRrzK3OTkydmeityx1yYgR2U/i+l4EJ
	 B4ugwtspWz9z8SLUimb4uOSTgoc5WkPa3LUN8lDsE+LEoW0swQy07Pv9k2t7dm6QiWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952063;
	h=DMARC-Filter:Received:Subject:From:To:Cc:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=mKSuIXJLtZJlgvRY/t+P/ubAjU+hVN+y583sjkS57DM=;
	b=Pq5+yXBpqDImDva3C9gnDMaAs0Pjc9uAMmN81SH8UweuvH+aPsV+1omPnGnyDeftUbQw
	 olM+wSb9vI6k0I0pKdxE1/Cr4deOKMcEWpSJ0Tv/lq7gBcfvAFDr+ikLuTbryn44QUzG9
	 dJi4BaDBYm9vk+rXrM83xxkZ4TwZR0cRMCmfDIldxeev51wSOAXP6y8QhZEN0kkryAMu0
	 Rqy9l+bT+nOcfVf/zW9jWzjJWtmbc6kIFxSXfEiI/LgeO3f9cVwJ6n+Cn4FNJrWRh9FL1
	 cxQzCxWKFuNODC1M+MnD27d78CrzuBjexdrFLK1D7kxIXaOQU3qYo2gWbkt3Ns+H9iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E782606D804;
	Fri,  6 Nov 2026 08:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E782606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACntpc3ie1q8DdqAA--.5010S2;
	Fri, 06 Nov 2026 16:00:55 +0800 (CST)
Subject: [PATCH v2] dmaengine: fsl-edma: Fix channel leak in fsl_edma_xlate()
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, vulab@iscas.ac.cn
Date: Fri, 06 Nov 2026 08:01:02 -0000
Message-ID: <179395206206.2118334.5568431940571202082@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:rQCowACntpc3ie1q8DdqAA--.5010S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1fCw43GrW7Kw45XF1xuFg_yoW8tr45pa
	1ftFyF9asrta1FyF4DCw40vFy0kF4rt3y5KFWDt3sFk3srtrn3Z3s8Gw4F9ryUJrWfZF4S
	ywnxtF95WFyUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x0JUMGQDUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMDA2rtTw3SfgAAst

fsl_edma_xlate() acquires a channel with dma_get_slave_channel() and only
then validates the srcid taken from the device tree. When the srcid turns
out to be invalid the function just returns NULL, leaving the channel
with its client count elevated and marked private, so it can never be
requested again.

Validate the srcid before any channel is acquired: reject a zero srcid
and a srcid that is already in use up front. With that, no channel can be
leaked on the error path and the release added in v1 is not needed.

Fixes: 6aa60f79e679 ("dmaengine: fsl-edma: add safety check for 'srcid'")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Check dma_spec->args[1] before dma_get_slave_channel() instead of
  releasing the channel on the error path, as Frank Li suggested. The
  zero-srcid test is folded into the existing fsl_edma_srcid_in_use()
  check, so the code stays where it is.
- Link to v1: https://lore.kernel.org/all/20260916092733.2002700-1-vulab@iscas.ac.cn/
- Sorry for the very late reply to this review.

 drivers/dma/fsl-edma-main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 630285c85482..e2ef18ad1a3e 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -266,7 +266,8 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 		if (chan->client_count)
 			continue;
 
-		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
+		if (!dma_spec->args[1] ||
+		    fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
 			return NULL;
 
 		if ((chan->chan_id / chans_per_mux) == dma_spec->args[0]) {
@@ -275,13 +276,6 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
 				chan->device->privatecnt++;
 				fsl_chan = to_fsl_edma_chan(chan);
 				fsl_chan->srcid = dma_spec->args[1];
-
-				if (!fsl_chan->srcid) {
-					dev_err(&fsl_chan->pdev->dev, "Invalidate srcid %d\n",
-						fsl_chan->srcid);
-					return NULL;
-				}
-
 				fsl_edma_chan_mux(fsl_chan, fsl_chan->srcid,
 						true);
 				return chan;
-- 
2.34.1

