Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449082;
	b=fzOcMMJ3TnNj2lt2+hAy4pNW4fFOrUqaDSsuc9c6Z96H0hHQy/bHzHs0eefexwLTtwLS
	 05v1CdbheE2DBmC72brL2cNj7yFEk3Vk4XRr0X6PYCue0TfgE5ay5WqeFB5wN3niQcX4f
	 a/rAnXFrXwLdanlgaIYPaGDuwiIcd3WyKz1BI6YKmy2PljBHH/scHs1EmO+Ecol60G9Y+
	 C/IQjA06tn1pIbhoHmC5QEF5WEckjvA2PDkTcjSMcEnes8VUOOPYS+xnJSHO9yWNRk04w
	 PvMNhdONYSp1rQzFOsz1hp+iIIUwa/oT5YOUb6cOH0g2Lh113wvDhEDM3sZbNDWGTJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/FGOc2MvxTTI0+I3WGWHQYsuPNe3/arM+difr8Q55Qk=;
	b=PqCVaiMeupyoCQH7Titrq/B6nvtxCp+QA1AyyxW4xhNQdoKB0WwqcnJ0FR+wNZcPimvv
	 w0pmQ292W1P2sFjVWgykdiNbVsjv6jxYBQD68Ax3GwVY3dBs2McP0i86hAX+OCnmusrzo
	 DzWhOB85fLqCb0QkAZA+RZ6eX8F/ZoD10UuV8DbK8sYLSZLbrcfmIN9JhbxiDi79JpyKR
	 oWaYeo825OHX+kDTwQdTEGGoJOZpbONIN4EqK3J8/rhf+VXTW38f/4A5pPDHw/teo53DC
	 3V/MCcvPUsM8EmkvclU7zGlDohENeYhB/cSMV4rfEd6Bi+oGFn7/nm39Ob6WRdH1N/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMzdxLUS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DED606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMzdxLUS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECFC1F00A05;
	Thu, 12 Nov 2026 02:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449081;
	bh=/FGOc2MvxTTI0+I3WGWHQYsuPNe3/arM+difr8Q55Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMzdxLUSvUsoICMjUelnZBzNYHA5sns8TPaqCQSARb/uTbBZuFITPl3vzVrlQCHsk
	 GETLf8SUAZA8ad4vLRrSG1JIVTT+5xouM8YyPThj6teLe8g6+d6rMvhcWTxfVMQloS
	 ORcR0dgobnc7hFlO7u6jNHQVlZqZntCwtN1jSMHLyhcdDiL7BJPZckkN8w/e5KOw7S
	 AYOewTeY7+RqeYMGflywJjnCPfJTr39GHia0YifThRkXlx6JxzjIgmGFt8PsO6h1Y8
	 /5PS4sRUpMh+l5AvaH4QEowNThKP4ErjP6/FkvC9w3rhdqYidqCC5bQDwk1/PtL6BD
	 ZMNgxiYg1ewJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Darong Lu <zzyy19904204639@163.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] libceph: initialize CRUSH choose argument weights
Date: Wed, 11 Nov 2026 21:04:39 -0500
Message-ID: <20261112020321.1302654-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052645-failed-6.12-c3a995ff0782@kernel.org>
References: <20261107052645-failed-6.12-c3a995ff0782@kernel.org>
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

From: Darong Lu <zzyy19904204639@163.com>

[ Upstream commit c3a995ff0782587789333c621e1f6bd5e574371e ]

Initialize the CRUSH choose argument weight-set array before decoding so
entries start in a defined state while the decoder fills them.

Cc: stable@vger.kernel.org
Fixes: 5cf9c4a9959b ("libceph, crush: per-pool crush_choose_arg_map for crush_do_rule()")
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Darong Lu <zzyy19904204639@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ sashal: replaced kzalloc_objs() with kcalloc() using an explicit element size ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 803514a1bc7ce..fdb8c398f5ecd 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -320,7 +320,7 @@ static int decode_choose_arg(void **p, void *end, struct crush_choose_arg *arg)
 	if (arg->weight_set_size) {
 		u32 i;
 
-		arg->weight_set = kmalloc_array(arg->weight_set_size,
+		arg->weight_set = kcalloc(arg->weight_set_size,
 						sizeof(*arg->weight_set),
 						GFP_NOIO);
 		if (!arg->weight_set)
-- 
2.53.0

