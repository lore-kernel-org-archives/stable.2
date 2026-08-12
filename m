Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD473AFCF1
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524720; cv=none; b=WrsRWxgZV4Zx3+YmnkInuEJ2DbJMyog1vXHj6eAc58Zw3iZotfWdaaTh2JZ9vNnrBhT310VhgRLOK0Gw3YQuCoQ1woWKIJnm1+YkiV+fumIWkaeYNB4gEMbxjMmT+q4j2iQ1HrsJ92rfA2Vxh4AJZxwb0SvRDwn/A7WsO7NYZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524720; c=relaxed/simple;
	bh=Rm9m/HmF8nNu6jwSCG5aLivvgGEjjTDPph5lFm533Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gBvC3PPrqmB5lJiIM1HkZNZFOvAw0sllkEYxtnr/uATHS6KfdAZE2tmagHbOdvBd0DP+WLr6rIUjQmwOmop5PC9CEcirBsM+I8bs0W0GZo3nKOmztAEsmEbTZtvGX1JfPxl1lT9mBDfifVZssZ8qvjnnhjtQd7veSf06Xx/AORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=JQ4AVzmg; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="JQ4AVzmg"
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id 1F3FD19F593;
	Wed, 12 Aug 2026 10:51:48 +0200 (CEST)
Authentication-Results: smtp4-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=JQ4AVzmg;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dlZLCzVIwFw3AUrCyywQJ95TV/TKPd5AK4EYp0F9ZhU=; b=JQ4AVzmg1RG3zn8r2sM8+U9i8l
	bUrwN2ffCtmvUne04VUvnUAiGpGcxA/mLzQaUGqg1TFTim7SsFHqwX5nNsToTgZ5Q9/i04+lrmxQi
	3wGIIelE1FAhbCxorEcwSvlzlbzzs4KdFqvr7GiE3HVwVeIs352NS31cPq+tGRoQEcZU=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.98.2)
	(envelope-from <guillaume@morinfr.org>)
	id 1wu4gd-00000002k4I-2CW5;
	Wed, 12 Aug 2026 10:51:47 +0200
Date: Wed, 12 Aug 2026 10:51:47 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, huangzjsmile@gmail.com,
	Chris Li <chrisl@kernel.org>
Subject: [PATCH 6.12.y] swapfile: call cond_resched() before locking si->lock
Message-ID: <anw0I3HwhISAvVt2@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The 6.12 backport of commit 66366d291f66 ("mm/swap: add cond_resched()
in swap_reclaim_full_clusters to prevent softlockup"),
added a cond_resched() after locking si->lock. Move cond_resched()
before spin_lock().

Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
Fixes: 60cbe67d1342 ("mm/swap: add cond_resched() in swap_reclaim_full_clusters to prevent softlockup")
Link: https://lore.kernel.org/stable/ansgKOOXi6KE3oKf@bender.morinfr.org/
Cc: stable@vger.kernel.org
Cc: Chris Li <chrisl@kernel.org>
Cc: Zijiang Huang <kerayhuang@tencent.com>
Cc: gregkh@linuxfoundation.org
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 552df432c37f..ed0a5ed25e65 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -770,11 +770,11 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 			}
 			offset++;
 		}
+		cond_resched();
 		spin_lock(&si->lock);
 
 		if (to_scan <= 0)
 			break;
-		cond_resched();
 	}
 }
 
-- 
2.39.1


-- 
Guillaume Morin <guillaume@morinfr.org>
