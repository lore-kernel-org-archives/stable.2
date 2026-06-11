Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CF397342;
	Thu, 11 Jun 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197688; cv=none; b=NCsJAeSCe7TalG0A77FOk9K3bE4VveczjwJpyZIlZ3VHx89U1jS4oWA02ySbXpWCLW0cYsTN5P0heuGA5qvby1asILhS5Kpag8uVws6WoqApdqUJoTzr2tr8O7nsuuh/w7CQOtk1hlrcoF9gjnnRA+Skw50vDa9lV2zviFSF3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197688; c=relaxed/simple;
	bh=qe6nTFG7YDq3kD0Ui2R12zRI7giuhC5prS9INYAGDhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X265V7tFCDn2O3Rj23RWLvTjNiHHuTTqe02hqZ9Y2bEgAzFS77KHlaWZ2aB6O7XhVv1zxiTOHds/hh0IjnHjTvU3+hQrCCk54Cw83+A7tklrqLGq4ZyJq2IYVRVJaExGIcsPXe3Px0kS02e/nSUuKyy9GZarIrpkpKTnAuQK67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowACX7hFu6ypq6ekaEw--.587S2;
	Fri, 12 Jun 2026 01:07:59 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: mani@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: qrtr: fix refcount leak in qrtr_send_resume_tx()
Date: Fri, 12 Jun 2026 01:07:56 +0800
Message-ID: <20260611170756.3590-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX7hFu6ypq6ekaEw--.587S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW8ZFW7tFWDCryDKF45Wrg_yoWDKFc_G3
	y0gFyfW34Utr1kCwsFkwsrZrsI9a4kGF48KrW3KFWft3yagF4DJr1IqFn3ZFyUW3yUtF1f
	Gw1I9r9xur1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4PA2oqzrtH4gABsa

qrtr_send_resume_tx() acquires a node reference via qrtr_node_lookup().
If the subsequent qrtr_alloc_ctrl_packet() allocation fails, the
function returns -ENOMEM without releasing the reference. This results
in a reference count leak.

Fix it by adding the missing qrtr_node_release(node) call on the error
path.

Cc: stable@vger.kernel.org
Fixes: cb6530b99faf ("net: qrtr: Move resume-tx transmission to recvmsg")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/qrtr/af_qrtr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 7cec6a7859b0..c9f892427f7c 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1009,8 +1009,10 @@ static int qrtr_send_resume_tx(struct qrtr_cb *cb)
 		return -EINVAL;
 
 	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
-	if (!skb)
+	if (!skb) {
+		qrtr_node_release(node);
 		return -ENOMEM;
+	}
 
 	pkt->cmd = cpu_to_le32(QRTR_TYPE_RESUME_TX);
 	pkt->client.node = cpu_to_le32(cb->dst_node);
-- 
2.50.1 (Apple Git-155)

