Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14532B102
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364057; cv=none; b=QKSTQ5rBMGq4l5tPdZpXKhsJxnOyheNv6BAp8GobIJ/9xJv69234ao6fVw8kNW/1yLyQEYaFbs8R7hIdjZtx5HR9cpl1uuoJGpfEGuWFJ5DVAHVhkwu7vOhZP/yRfUZ+w3DkxEMqQZxyDX5SuNc/UGtYfjQEZHMiUk96oiCCOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364057; c=relaxed/simple;
	bh=futA2E2BI054EkkMAf/9xxA4miiP4yekF1HvC97jZpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAeyQ7AYRbeguqs8pnoRoiPMjX8h2asjFhfQtYS+54c8BDYKhzUXjnMdU3w7fjBhE6B53+xDL7eXioHLVZtqpoIBT3vZBNK6q48f5I/kdOXKPXO/vi71tznR37buWH7jwaqHesSx1nrJgeRznAkJWBRdzpnfMRojAqO1DBqp7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVhCjgx+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVhCjgx+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c20ce3c118aso2003566b.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364052; x=1788968852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q3wYS5mR5Zx6Crt9XdIdwTT/Ll3ikWEO9/OJNepkXHY=;
        b=MVhCjgx+U7G8QMONbWrIwE7QOXm2Hm54S1glwX2avnEcclTVaBvmzl8mdDHXi7WYRL
         t145YKiHQHUcI3bhoWlHv2RxGTt5Ln+iNU7ELGRsxwSeq+mlBxqUHVuAH+i2ZKPWyynU
         SviLCeweDyiY5ZbLbHkuvog7hAf2G8oSXNcbTlVuegt7ccoaN4pOJmL5KsbLysuSyaGm
         fag6W1v1fbzeKf2XR36nos43wff0WShdOnJvrST4czeJBCK5dI4RRmyxM5z0hXl7wXtW
         T/3Q5AT96//z88KeE1zacyBXHYXDamWvh6Z31w5Qe7+/q/QkYJRdtnhAhHHuAAhyFhRZ
         BRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364052; x=1788968852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3wYS5mR5Zx6Crt9XdIdwTT/Ll3ikWEO9/OJNepkXHY=;
        b=RJe/rRMrV7v4FiUkUzBnfvWFZf68MzGjVdnl2kT42XxN2/tMKyFgr+O7onpjQRhMqH
         ZTClIvoDSlPbN4v5nGVDuDSalEoRhRyYDe69tleYxPSi2MPcf5ppIZkrge+FQFIFBmm2
         fjyups4UKVpPDQJ48HjuARTDLo3WUzPEzXvt41Cq3hHE2X0PTf1WFWhGf5bqPfwgBQxb
         iP7LL04r2bQ/Zk1eQhPrKiWw0LeGPkW0sM7b2p4rWFAZS3aXLG/dV1ekiNJK/8B50311
         F2rKYrgDlCGdmUMldAay87CahndwdIn4b1mUlb8K8TBpUe0+HjFRqx1m9hUdkIpc6LNs
         kjFg==
X-Forwarded-Encrypted: i=1; AKwUvBy0SIBVcrydCYx5SPX1SgDRNd3FFnhLW01wyLjxIfH9HWFX8snq1AvX3mCXL0I4QVb3o4ysuQc=@vger.kernel.org
X-Gm-Message-State: AFuF++n/OOBJT57GmMZtFiYIs2Jj/5WH3urcfhL3cMEjLahivPYDAtAb
	TGOG6OtKfMV9lputQxbr1SUYS3p1lzB9swL0bI0ss5LygSBDjCVOisAGX5XE2MCepz4=
X-Gm-Gg: AYBFou1JJsYNjmPW+RCTak1HuLSRVn2YA2Jf0LjyDEeh/H9Gn99YRMcfyePDEkGSInK
	DFapAnvq9Zgpue7IXaVVGZOaAF6Bla3nYNgvODx3TVfYkdHGWemiAwoQLs56FagSeZ8M7DXFOx4
	FMBeidUZdmKKT6cN/c55/AI4IKNYtUA1oHW9zN160bPHgfUSaLEI/cWP6zx4Q9HHGFIoYsVccGs
	GPdXrH8EmlRDROMN764ccQKlwPSA3YCLqlcZx4053XXa9DT2F0qv7nlRsb3KQzzvpmjQEE5uRoC
	W2CAks59SEbLWdiQvgXYMfmzJipyshW8csOWwBQGDii5a7BF0pRjzDx4T+4GH6EDXP0rGRAkPn5
	imsj14hbThCEbSgPiEU/ETHxfM+3fGgIgYSNyF8wftPHNS+QboTBvn+oE0MSBKN0u7g6YD2YfMS
	G/KQBzUzjSBmqhXocCWfbAraFMStDbuEkglUSvSMqbxy1aLqF6atnRhbMKtWAOgbIyUJMk5MRTK
	bPePAfFyqPkBQ==
X-Received: by 2002:a17:906:618a:b0:c25:8bf0:36e2 with SMTP id a640c23a62f3a-c25f0187452mr6712366b.10.1788364052039;
        Wed, 02 Sep 2026 08:47:32 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72c28sm7532741f8f.6.2026.09.02.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:47:31 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	idosch@nvidia.com,
	razor@blackwall.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net v2] vxlan: vnifilter: validate the VNI range in vni_filter_entry_policy
Date: Wed,  2 Sep 2026 18:46:09 +0300
Message-ID: <20260902154609.594009-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VXLAN_VNIFILTER_ENTRY_START and VXLAN_VNIFILTER_ENTRY_END are declared as
bare NLA_U32, so neither is range-checked before vxlan_process_vni_filter()
passes them to vxlan_vni_add_del():

	int v, err = 0;

	for (v = start_vni; v <= end_vni; v++) {

v is int and end_vni is __u32, so the comparison is unsigned. With
end_vni == U32_MAX the loop cannot terminate through its own condition:
v reaches U32_MAX, wraps to 0, and 0 <= U32_MAX is true again, so the
request never returns. It runs under rtnl_lock, which is global rather
than per-netns, so every network configuration operation on the host
blocks for as long as it runs, in every namespace.

The interface is reachable without privilege: creating the device and
adding VNIs only requires CAP_NET_ADMIN in the network namespace's user
namespace, so an unprivileged user inside unshare(CLONE_NEWUSER |
CLONE_NEWNET) can trigger this with a single netlink message. A VNI at or
above VXLAN_N_VID is also accepted and stored, although the VXLAN header
carries only 24 bits.

The MDB interface in the same driver already range-validates its VNI
attributes with an identical constraint (vxlan_mdb.c, vni_range with
.max = VXLAN_N_VID - 1). Apply the same validation here.

This removes the non-terminating case and rejects VNIs the header cannot
carry. It does not bound the cost of a request spanning the whole
legitimate 24-bit space: that still creates 2^24 nodes, each with a
per-CPU stats block, under rtnl_lock and with no reschedule point, and
neither allocation carries __GFP_ACCOUNT. Bounding or accounting that is
a separate change and is not attempted here.

Tested in a QEMU guest on a KASAN kernel with 2G of memory, as an
unprivileged uid inside unshare(CLONE_NEWUSER | CLONE_NEWNET). Before the
change, a request with START=0 and END=0xFFFFFFFF drives a global OOM
with the allocating task in vxlan_vnifilter_process(); after it, the same
request is rejected and in-range VNI addition is unaffected. A request
spanning the full in-range space, START=0 END=0xFFFFFF, still exhausts
memory on that guest both before and after, as described above.

Reproducer available on request.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v2: rewrite the changelog to describe only what the patch closes and
    state explicitly that the cost of a full in-range request is not
    bounded here. No code changes.
    v1: https://lore.kernel.org/netdev/20260829030041.940594-1-alishmery18@gmail.com/

 drivers/net/vxlan/vxlan_vnifilter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e0886..9e86ac39cf9d 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -459,9 +459,15 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
 	return err;
 }
 
+static const struct netlink_range_validation vni_filter_vni_range = {
+	.max = VXLAN_N_VID - 1,
+};
+
 static const struct nla_policy vni_filter_entry_policy[VXLAN_VNIFILTER_ENTRY_MAX + 1] = {
-	[VXLAN_VNIFILTER_ENTRY_START] = { .type = NLA_U32 },
-	[VXLAN_VNIFILTER_ENTRY_END] = { .type = NLA_U32 },
+	[VXLAN_VNIFILTER_ENTRY_START] = NLA_POLICY_FULL_RANGE(NLA_U32,
+							      &vni_filter_vni_range),
+	[VXLAN_VNIFILTER_ENTRY_END] = NLA_POLICY_FULL_RANGE(NLA_U32,
+							    &vni_filter_vni_range),
 	[VXLAN_VNIFILTER_ENTRY_GROUP]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, daddr)),
 	[VXLAN_VNIFILTER_ENTRY_GROUP6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
-- 
2.53.0

