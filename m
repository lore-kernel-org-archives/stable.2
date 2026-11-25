Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606394;
	b=SfoIiErgzqO/fCVjzGXfHYbhrgvgOo7s9Zc3L2ix+CMgms66Bql4/uIzTIcLweIK+I1G
	 KoSaLfjQFgw3x2bHPED2gG9GdS34uHM+r+ShjhrstrFN6Dbd4548awUAe1ITINwY+497l
	 E36vOqas7dETEDlUwqgBqLQtvpu+dymz1R/SpxugXhuoHkN1ScNnXbfjec79wGbdWxQzi
	 i7DuW4TgVXVClrGvfHVy7QGSgGhfXDUZjVCH9eUQuW2Ghie37CqplGdO64ruuGGq9EMvk
	 TYmwwlvqd3TjxTUqpzRsHwUH3dZkFaLXSdlxif4rpjjPnrvNBYUuEJJArYN54zg0H8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606394;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7v7pRybIQgAjKNT2eMVhg68jR/kdfTOjTvBtVb2gYQI=;
	b=NdWut1XXNYBP1/V87NUoL/eRVBo7aucHJNbRT88QA0IKO5/YOgsonSPx2uQsbofVc1hO
	 oA5Pi2Oe2Ob8CclmEKBmZTWrRA/LZ1AvV96MOyK3oF6kjk1twVbibs9qUfE12RcAX64V+
	 85m3VOncdT9KmL0ntAOFKJ9HieFqgcAYXzLPnlZxEL8Bxcfbr4tWVbhMSR7YqCu7Y+M9H
	 7D3E4kcsG5Tp88KTu/QuyAF/E5OfRs3BDdbFEvOWpTTZ9eGee5xxDj0KQ/w4XNRw1H6Dc
	 KJu1Od8do3cHQsQ4TaRDs1/LRTCB44NFprJlYr2u0ByBkQ9eMQV7dsOR8vsb3zEPcLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bNTJats5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20815606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bNTJats5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690F41F000D2;
	Wed, 25 Nov 2026 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606394;
	bh=7v7pRybIQgAjKNT2eMVhg68jR/kdfTOjTvBtVb2gYQI=;
	h=Subject:To:Cc:From:Date;
	b=bNTJats5pcR4p+1R6f0KzglaNhbqVo2nLvzxn5JDinLjHF32lUs7r2vd5EKKZOQiE
	 UBudbxTf5oeqmaHe8G49GFaxoqyApV4JwQHYUwW+GgiRQkxMeyCmOV4RCe3ikc4xd4
	 GNHhvwB2KxgfVNyqma/d4WYZ5nAA76PbeBbXfQvU=
Subject: FAILED: patch "[PATCH] dm persistent data: don't ignore writeback errors" failed to apply to 5.15-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:20:46 +0100
Message-ID: <2026112546-flirt-danger-e920@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fa887f2ebee7aff97eb87b3365939616ade09774
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112546-flirt-danger-e920@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa887f2ebee7aff97eb87b3365939616ade09774 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 6 Nov 2026 19:48:02 +0100
Subject: [PATCH] dm persistent data: don't ignore writeback errors

An error returned by ie_cache_writeback could be silently overwritten by
another successful ie_cache_writeback. This commit fixes disk_ll_commit,
so that it doesn't ignore the error and returns it immediatelly.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Fixes: 6b06dd5a9722 ("dm space map disk: cache a small number of index entries")

diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
index 22a551c407da..833aefb0ab99 100644
--- a/drivers/md/persistent-data/dm-space-map-common.c
+++ b/drivers/md/persistent-data/dm-space-map-common.c
@@ -1190,17 +1190,20 @@ static dm_block_t disk_ll_max_entries(struct ll_disk *ll)
 
 static int disk_ll_commit(struct ll_disk *ll)
 {
-	int r = 0;
+	int r;
 	unsigned int i;
 
 	for (i = 0; i < IE_CACHE_SIZE; i++) {
 		struct ie_cache *iec = ll->ie_cache + i;
 
-		if (iec->valid && iec->dirty)
+		if (iec->valid && iec->dirty) {
 			r = ie_cache_writeback(ll, iec);
+			if (unlikely(r))
+				return r;
+		}
 	}
 
-	return r;
+	return 0;
 }
 
 int sm_ll_new_disk(struct ll_disk *ll, struct dm_transaction_manager *tm)

