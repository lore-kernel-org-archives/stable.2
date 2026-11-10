Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273911;
	b=yDOk+OuN/2olwaLXqk3WmwoyCSSJFFqfYa4rfnAZLh8F9AAMGj/YPhz+2QyU/DeANcVw
	 Rqct3hbOi4TGBzmNsbuJwBPp3y7EgIkb/loet21lBGfPc5Xm27zWR3edwsc6UaVNG92gm
	 jvnzsb0Bg74qdvzSQiWYFJ3rpchvOE+IbmWDw9Krt97SQoq0KFZKlNBdUIQtww1DCQfcB
	 iK7yEUOU1x+4u3qCcI8sGhDHzqdX+OGfNeRCAsII7Rmf45HWW6iWyWuhUqTrN+Tusxpun
	 MzfTKvv24E/TieF/79TBM21+ZpgDH14h/yvCQuZkGG1VASE3r8bSsDEt4zdoUiuhmeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CHDsOgfTW7yc5UIQ+xa/Pgsx8kHJY8gjF+rRenonRh0=;
	b=ItzRA3yCC+pdX50ezEIoixx4Ku8Pa3JCAAsYdTTwnHoSrV59SHatWJEC1AZDRouzv9j0
	 q1AfoHJHsTp0ozX5+8mXfukXIcdGqTIqlD4sJPXyQEsOdsfQa7kHsJjukzrrOTGuUwZK+
	 pgROSicn3tNOnClKGtrmqE81fOv8KRJYxatul6YzJWqKI1Fr+LizZys0cg6WtxiZNQ3cd
	 h43VWEvP0GtRSdCaZPoMhobZlwSU+WZbsxsHvnZf5uLuqicZE4fm/c77s1dVyj9/0uyN6
	 Ac+4hQnSbT4r6CCwoGsCzcjVMJPClgIGdMFo/tH4EMHa7RTzglD8T57IdeyYV43SRKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCrL3USp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF00606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCrL3USp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FB31F0089F;
	Tue, 10 Nov 2026 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273910;
	bh=CHDsOgfTW7yc5UIQ+xa/Pgsx8kHJY8gjF+rRenonRh0=;
	h=From:To:Cc:Subject:Date;
	b=DCrL3USpZw9teFmaRF9UGDGtz1bHON5VqTpEd2JpL8A7vNZukICbnDxBfRrFnq9yp
	 emCKrP74w/9KJZopqZDIYACk0fN6yLVT328MU7PUQxfADVXfYoUR2Ay52yJVGdmKug
	 QmTzW/2ekp57R3DHpBGOaL5hzxCoSWG08zG/qsoYLp7V5OscjivY5UJLYc7/3jPPZA
	 59X6BeJ/yRVUz4jta2grNnhqLmEY/9NwPGyMWoLGJYjcQ211tb8hG3K/i9HZmzWtNh
	 fNAkRDbBOmIQrWlMGVICIs0Wv0RWKkgFUXtb6uxQG6df/g3Xj3UCisLwsidUWoMMG+
	 Iyae7SAFsFCXg==
From: Sasha Levin <sashal@kernel.org>
To: gyf161023@gmail.com,
	sstabellini@kernel.org,
	asmadeus@codewreck.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong tag" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:08 -0500
Message-ID: <20261109202508-failed-5.10-4d183e6f1532@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4d183e6f153245aca2534e372152583b868dd925
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202508-failed-5.10-4d183e6f1532@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4d183e6f153245aca2534e372152583b868dd925 Mon Sep 17 00:00:00 2001
From: Yifei Gao <gyf161023@gmail.com>
Date: Thu, 6 Aug 2026 14:42:54 +0000
Subject: [PATCH] 9p/xen: fix refcount leak in p9_xen_response() on wrong tag

p9_xen_response() looks up the request for an incoming reply with
p9_tag_lookup(), which takes a reference on the returned p9_req_t. When
the tag does not resolve to a request in REQ_STATUS_SENT, the function
warns and continues the loop without dropping that reference, permanently
leaking the p9_req_t and its msize buffers. The reply header, including
the tag, is supplied by the backend, so a malicious or buggy 9P backend
can leak kernel memory on every crafted response.

Drop the reference before continuing.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20260806144255.4167019-1-gyf161023@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/trans_xen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index f9fb2db7a0663..8eea0da8797f4 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -203,6 +203,8 @@ static void p9_xen_response(struct work_struct *work)
 		req = p9_tag_lookup(priv->client, h.tag);
 		if (!req || req->status != REQ_STATUS_SENT) {
 			dev_warn(&priv->dev->dev, "Wrong req tag=%x\n", h.tag);
+			if (req)
+				p9_req_put(priv->client, req);
 			cons += h.size;
 			virt_mb();
 			ring->intf->in_cons = cons;
-- 
2.53.0




