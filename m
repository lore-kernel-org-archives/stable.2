Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357469;
	b=zdxa1qSvH132/BhZk806/vpwo0i9ncQjPzY7W1Sls4PHe2LD75VfeOCRltxDZo6QDXKI
	 3yoPs55dKGsDkgohz+IirVAb/PKO4WCH4J8eDnkv8zUx8EWoiqI0LrvkV2t66S28zJriB
	 224Enx4BRcdQm1IZ7wdSnW6rKngyKel9pcm7Z/5DVTo7e9c8eXSohYEg2yrsUdvtWxru0
	 gGydMziQeyXJ0QkuF5xco/hdyzqCwqxjR1tBVs9JXrfbgHHeQlVUfGfl6n3gA0RD1eTP9
	 WX/LkeN0gDMWk71EQtWnT+ptvDrIf5OwsxkOEGZxWZHVpDHGyMcRn+MTNOqYcTfCSZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w3lpUEkcUYB/TlKYKSFUD/2jahafwW7V7JoiZ9VtH6Y=;
	b=ylyQFjWH3naiCFSHqzYbhuJblRs1Y6d+kb+Ybkz4rSvFInPj5qRqh9ZSWzy+OePiJ//6
	 eMIcSBU52puAxSiWxxHn0Kaj3BWrJG87SF1pmaTTGmoeiZrOGCFXHCYXMdUTKgcBye+L0
	 ikYYtNoMDMr13CGKOJ42KeMF8Fiu/E68Nys1VtWPvuhYHfJwYNOuoGpvD2cW9hi+WU0KB
	 czAiEQCEYTw3dfMRIgFuM7Ffv7NpgNnCM5ya5LNWbvqfknfL9+cfwzSrvq9eyLo4UUKrq
	 M1FZoMco5qZZ651O7+atQUn/r6HyeMpz7z5V4ee9M6Fq0GFsJCaj3l+HpDh8hhpjOGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjJjD23o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66257606C6CE;
	Fri, 30 Oct 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjJjD23o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDE41F000C1;
	Fri, 30 Oct 2026 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357469;
	bh=w3lpUEkcUYB/TlKYKSFUD/2jahafwW7V7JoiZ9VtH6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BjJjD23oYgzg0TMkY67MwlEKJqdXa0GLSNRzSMAM10pfZkkW/P0RyAnfDWN/M4gRG
	 i5xSVkpgFSk1znqHltnDnD7aks6yth52ey61KdaCp0sIwkeN/vamnGFuwHyUaFZaJq
	 NO7uoam56aICwcGPaqFVg3Cr2pM6pW9G4M+kKsVyFT82GChklzNme0NXAc1JfQlIQe
	 +1YCtEHNd2E5IgplwFXOPXrOqfwRF/WvpDN8snJvxDtAxEabJfVT3kHuY+4WvmfZ6A
	 bY5ekz2wt6DdQ3lndTW/Ha3SphK3k7pPZhgMk8ajQN3cLE2nzZ8fJv6od/hklZV4P2
	 Rg5gM9SczMvpg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/21] soundwire: qcom: Prevent pconfig buffer overflow in qcom_swrm_stream_alloc_ports()
Date: Fri, 30 Oct 2026 10:46:46 +0000
Message-ID: <20261030104840.3361217-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
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

qcom_swrm_stream_alloc_ports() allocates the pconfig array with
ctrl->nports elements, but only checks that the assigned port number pn
is below maxport.  When multiple slave ports map to the same master port
via m_port_map or the stream requests more slave ports than
ctrl->nports, nports increments past ctrl->nports and writes out of
bounds of pconfig.

Verify that nports is less than maxport before writing to
pconfig[nports].

Fixes: 9e53a66a2f2f ("soundwire: qcom: deprecate qcom,din/out-ports")
Closes: https://sashiko.dev/#/bug/linux-543ea0c0-a6e5-4b03-a041-ea0a760802c1
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/qcom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 6e0c5fb10efa..205011234030 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1343,6 +1343,11 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
 			slave = s_rt->slave;
 			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+				if (nports >= maxport) {
+					dev_err(ctrl->dev, "All ports busy\n");
+					return -EBUSY;
+				}
+
 				m_port = slave->m_port_map[p_rt->num];
 				/* Port numbers start from 1 - 14*/
 				if (m_port)
-- 
2.56.0.317.g454f8302e1-goog

