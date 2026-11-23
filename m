Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454515;
	b=VzSwsaW4a/CMVcx8ydCY+uOCQbIatPK2PUFh4sldo33CSvGyFZdC/Bu7kd6UyJpjMakj
	 7AHWnSZCZGnj7nTcivkC4T5iyaW5JAPcvB72WwD8RkKqnNTehGAE7tQdFwFq1VWbUJcRP
	 C0PvCBMCs5PxMydNqCxGoVfinNPE/S7008xog6CX5x5tXGa5hYRH+YzFcURwULn8wuCs1
	 3f9RDAdxsD9wxDCVWUlMa5uv0AXsIgway9zG5C07AbL0IqjRtnxfKnTreIjFXwnLseDlV
	 YhCTyCMMLo841XF2ul3owBPujQLyNfYlVQ6WbeZcuGMWIHlJpjXFWPoLWbsOjs+xYTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mzmVtp8arZSojXGIQWiyqG9ZRH/Jdc9g6dYP3LNdJss=;
	b=b6Bcaat1GxQPwF4jzaHJnKLm42cQETbaWpnXiKdRlbhV2Rin2AcHR17mwCsNwxGvetPU
	 R+NdDODrtl6sIM0qdCheyfN+m7yFAbmWf3Tlj9nOsWEVknB1UlEYf9r7pq9e1CcQ3ReEc
	 BsffKcEXGji1TnLZGw4bSILwLp9RZhZhNNzLa2Kb2ENhgAEeq7WXA2IeHUJb5h9QGRGtV
	 oWMyI6PaOFee1YFEunb4VcOiE+b1VgS4CBIMXpNAYx4MHuhYSG2XiwsA/J3sFAcVJOBFA
	 AqTiMXXadR1LZGJc6G6rw5AhOrL9X8nfKdtqEskxFpE+RjLCw2rXu2Eohg3VOxRdN9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQO5mEMx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10C2606A31A;
	Mon, 23 Nov 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQO5mEMx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501C11F000D1;
	Mon, 23 Nov 2026 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454515;
	bh=mzmVtp8arZSojXGIQWiyqG9ZRH/Jdc9g6dYP3LNdJss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mQO5mEMx0kHoanY+hWR78Pbfm6bsj1VjfQ2ngvaCVjFB9qOcH5Tb+rWu9QDoDvy5J
	 xGGIvgf6a+f6HQJZ4iHEEDGjvyNeU8BJiSaE70B7xAe2WMM/hlOzZJoceUP8jTCIH2
	 JqbVYRBb9RSMCB2aLQXymb0ez3daDxsmZVj2xwU9+tD+PM9CXWPVRktltCqmc08H0t
	 KWILWF+hNJC8WrV+rghbfLFyb5gyHaFQHMKJCwBkGd+qubbVGbXlTUNIsI618jJ8hU
	 XCHqgsapWWxgd5PtEt7Wcr3AUCe/ILUqHMv6sMi0Vr36DMAmIndRYWSsp8T/zwT1g/
	 CJEZY7ww2UqxQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	Brian Swetland <swetland@google.com>,
	Mark Grosen <mgrosen@ti.com>,
	Guzman Lugo <fernando.lugo@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Robert Tivy <rtivy@ti.com>,
	De Leon <x0095078@ti.com>,
	Loic Pallardy <loic.pallardy@st.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] remoteproc: core: Fix integer overflow in rproc_check_carveout_da()
Date: Mon, 23 Nov 2026 17:20:45 +0000
Message-ID: <20261123172140.3547896-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rproc_check_carveout_da() subtracts two unsigned 32-bit device addresses
and stores the difference in a signed int variable before checking the
carveout bounds.  When da exceeds mem->da by 0x80000000 or more, delta
wraps negative; conversely, when da is less than mem->da by more than
0x80000000, delta wraps to a positive integer and bypasses the lower
bound check.  Furthermore, delta + len is evaluated in 32-bit unsigned
arithmetic before promotion to size_t, allowing large da and len values
to wrap around 32 bits and bypass the upper bound check as well.

Since len > mem->len is already rejected upfront, compare da < mem->da
directly and check da - mem->da > mem->len - len using subtraction to
eliminate signedness bugs and integer wraparound.

Fixes: c874bf59add0 ("remoteproc: add helper function to check carveout device address")
Closes: https://sashiko.dev/#/bug/linux-8c4ef7d2-a95d-4267-b41e-9023431eba23
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/remoteproc_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 23f8539a99bd..2b2ebf39a40a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -287,7 +287,6 @@ static int rproc_check_carveout_da(struct rproc *rproc,
 				   struct rproc_mem_entry *mem, u32 da, u32 len)
 {
 	struct device *dev = &rproc->dev;
-	int delta;
 
 	/* Check requested resource length */
 	if (len > mem->len) {
@@ -299,16 +298,14 @@ static int rproc_check_carveout_da(struct rproc *rproc,
 		/* Address doesn't match registered carveout configuration */
 		return -EINVAL;
 	} else if (da != FW_RSC_ADDR_ANY && mem->da != FW_RSC_ADDR_ANY) {
-		delta = da - mem->da;
-
 		/* Check requested resource belongs to registered carveout */
-		if (delta < 0) {
+		if (da < mem->da) {
 			dev_err(dev,
 				"Registered carveout doesn't fit da request\n");
 			return -EINVAL;
 		}
 
-		if (delta + len > mem->len) {
+		if (da - mem->da > mem->len - len) {
 			dev_err(dev,
 				"Registered carveout doesn't fit len request\n");
 			return -EINVAL;
-- 
2.56.1.750.gf70dc682cf-goog

