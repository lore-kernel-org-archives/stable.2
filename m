Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413922;
	b=PdPBRZ24K6Brlu0gi08hKgWe0he7kzSAhH/DDSw/XXC2ClecsLre+HoDAwxXng5yUzuE
	 wUSx7j2U9sgZSH8kQC5Dm3+EzH+7/Bq/gnRnXdVXQO5ap+ydfEv1PfwqYioYJaK9LHq0l
	 ZeDRo0FkDbkXa6aCRnv/fxG2uxMPaOzxsGSZ+Dd1QrJLkFEaGR0Rmf4P0+y8MHcgwoYBK
	 Qbuvp/NzxAUUtRQ2TlxA3elju1PPejIbibx1Hhn0dFzAEskhHoiGau6ZQdehYCdotijb4
	 u2O3dhMB39fdl03f4D98OKX7J3kKAVg/IVFukb+vVQDZ7/Scua1zE/2NPnYQ+Tp5VSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tl93JRlsuokDAZ/kZAYyC2gobOkeon3ZjeST6XHzX88=;
	b=uEuulNrgYItyT5wGMmYkB0Hf/QQPQ8Guwyrmmm5pcIpNnERP0fQRPOB9EDZgSUzl+x6+
	 qJREEexTgCRBOTsjA7HJWp1pMF9M8TviF9RPPd4pEtKwEFJ+NAiBS2CXo+CZDs/ettC/d
	 btQNHKu6hOQA/SnPFCxknkHvxRGxkKL3wJMyeLgwclQdTGxKu83FY/wf3v/l4FekesSYL
	 WjGqK17JusHVdXpDW+Ni5VDkpMiAmkBzVnrEcDMOtHb4YlSlgfaRTTPOX/i0iWQfH60ny
	 1G/SU19XlzR8g+FShnGORxZoJv3VnVYkCV3e25i17TUxOhmaDSXmNnEMy/mbtIfRKZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=gKStaRxV;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043360A3811
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8043360A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=gKStaRxV
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so2196412f8f.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413921; x=1795018721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tl93JRlsuokDAZ/kZAYyC2gobOkeon3ZjeST6XHzX88=;
        b=gKStaRxVo5TTjFggIqYp7llrrzPcPl69s/GyATJGxs41sZ0V4cyMGFkBrH/x6LMWlY
         rMSSEiHNHFVmqZ7EpXsGhR1b5yv0ik3kyAcyJ0sMi96QNRuLdLgYYPReEXAuQlx3PEmf
         h70aKddg1nWWkOmUdN27YvD5SaMgRqwov54stAPfpwkyKt34fJoy5Rqvqt5pMkIaSopk
         LDSA6kACTUw+Rh3y+lXxB1tTFrdrF26jVk+DG96N7skf8AB0G7d+m4WGaPUKr78P3n5n
         rMkOwhMggK4QyH8u+UtVAd7OR2aUhZbhfxm5HAjSLf9B5e3hKcMyllDAhs/5vyhytI1F
         lbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413921; x=1795018721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tl93JRlsuokDAZ/kZAYyC2gobOkeon3ZjeST6XHzX88=;
        b=qOVYsDhdJLtaEKuXvcJluwr49aMObc+T13bByUptYNZcZg9EbzoFNeIC8r2mU30bzw
         ZvXA3wUn9zIFue6pq5YtA7Pa3cYYdntPf6WWLjnlbc381o9UieTP5E1a4Mo+qGcf22A8
         8RZKfUJkBOYZgA5ryex/T8nsIlYAeOak3M5nN/6BKHyt1r+w2pmQs1JFI5yzo+TgXWXP
         vE+lYZuz64Jt0vJoULYXGzDzAdvPvXFq9QsWplYQcByBqnUEz79dnbwNLTol16DgT+Me
         tZhspixvv1TJWTI+7jgr20GD+8mjYPjf2h0bbMAMI1U00xfFGcsVFhntO9ut/io5QdqI
         9Fhw==
X-Forwarded-Encrypted: i=1; AL+hErFhAL4ADIL/nd1X3E8zIghVhZ7KKwCRH7I7mhd/fSmI7O4A0zwBg5D8Jx0ObTZlFJurMUdbFew=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xQlT4HN6E/Oh9gBdp3W20XcmmaGYqhZtBlqKXvnSl5oCzrlOb
	dLbLwT3Ra16gLPCqAU4KyVSewr+BJtbZixSvOajvaGCo5djKn1MWGdCagInPKXUUyco=
X-Gm-Gg: AYBFou3EqBJlGfvlMgmTUKV8/Lso6TI9z1CEI/MuB59hzExhfokh1/QMONduDXD+a1P
	Li4CeYD+Ko8OdpPXAGrvp1eg+jN9+MC3JnGYau4ycHfeu8Dq/gPzeCv6S0NwV1GXu2bqnZAiD3G
	VwstVHzJ85iaam+fllhQKsKbgxm2j3gKw0qwjjf3x1S4EhSyHcWsG4AFkw8n942Y4VrbgLIJZ8W
	+mH3p/cpoVfO16UF7HuzjGyqdOyN7ALsqX+HerXwDq3EpMIeoechO1nJj7DrekbW7N8XqZiWl7j
	Z+lvQP9osM0YM/SDGWLZzLy/k/NRJ6aE+ubPGJW43Q7JCrDkR5xB4sM3dYA/V1dKAwWMY5yno/N
	kqHjOJE/XBKaZkTS8uWxlpZFAp/swAEq4i1WMqQ5lp9wN7cvvQjnyvsBcWGNiWhtaTJNREm3ycI
	tIv9AXSEwWmVwPSqjG6zwyWy1caCgx35MJmYUhBLKCAV/1fBsHDFIuG1V/XAHP8ApFtqWYSqFFe
	A7GsPWmx7TKJzOcRAmtUhhiwhnjoBFyBxzGD/EeKivsgSTFzK2Ss14yG3cyTpphllrKH7e3vtaR
	eS29fuw93GoWwy5DcFbmJxfGjYI7BhdAqMWsjjeZDyQCFjc8sXOfkJrSqaVrA6xu/Ykd5IOIe7E
	MOUh4AfbvNgboQ0OEDYbLuosP/+A5EceWp56BlIFv1vaHMQ3sxk0=
X-Received: by 2002:a05:6000:4914:b0:48d:f391:5c45 with SMTP id ffacd0b85a97d-499c6f8d953mr4709372f8f.42.1794413920839;
        Wed, 11 Nov 2026 08:18:40 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/9] ceph: fix mdsmap use-after-free in ceph_get_tree() error path
Date: Wed, 11 Nov 2026 17:18:27 +0100
Message-ID: <20261111161830.1336485-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

When mounting fails, ceph_get_tree() calls
ceph_mdsmap_is_cluster_available() on mdsc->mdsmap without holding
mdsc->mutex.  The MDS client is still running at that point, and
ceph_mdsc_handle_mdsmap() can replace the mdsmap and free the old one
concurrently, so this can walk freed memory.

Check the map while holding mdsc->mutex.

Fixes: 97820058fb28 ("ceph: check availability of mds cluster on mount after wait timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 01f92d77ef45..94ff935492e5 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1364,6 +1364,7 @@ static int ceph_get_tree(struct fs_context *fc)
 	struct dentry *res;
 	int (*compare_super)(struct super_block *, struct fs_context *) =
 		ceph_compare_super;
+	bool available;
 	int err;
 
 	dout("ceph_get_tree\n");
@@ -1429,7 +1430,11 @@ static int ceph_get_tree(struct fs_context *fc)
 	return 0;
 
 out_splat:
-	if (!ceph_mdsmap_is_cluster_available(fsc->mdsc->mdsmap)) {
+	/* ceph_mdsc_handle_mdsmap() replaces and frees the mdsmap */
+	mutex_lock(&fsc->mdsc->mutex);
+	available = ceph_mdsmap_is_cluster_available(fsc->mdsc->mdsmap);
+	mutex_unlock(&fsc->mdsc->mutex);
+	if (!available) {
 		pr_info("No mds server is up or the cluster is laggy\n");
 		err = -EHOSTUNREACH;
 	}
-- 
2.53.0

