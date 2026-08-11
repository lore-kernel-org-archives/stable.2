Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805BF2F8EA3
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454624; cv=none; b=kChwbWWNyQz+hO44NeCmmx4j/5gTOop9mx66R3/45eny3a3/4UZJEfhzl1zcfeBH0IvLXQS2tg8IWBskAqqrGxcjRG70D7S1blXXDHvOYEbknPeKhjB3Nxvv3+QkhTB678iL/pVmVr2txsV2atgcjuLRR+MeEeoTfH6fn5r7el4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454624; c=relaxed/simple;
	bh=ktjNH9FAZ14JcPyFtZGaSAGiIE98+R7IeYWVv+5rmlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BuJFC3tYCZD0tegiWY8VnmPHmvHv+67+lCv5rPvf3codhLTvlk47SlAfZkVUFmR/V28erUrtSHR5zJc0qOpBIjrKddmd/Hb3Jzl+FQVbyAqdPfeCCTP0cnfiqOWoPCnbOfy6yJTD0tAQ3F0IF2erI+zNOZwm+xPRk9lUUtrz7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=zxSPubJX; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="zxSPubJX"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 216B7DF9A2B
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:14:33 +0200 (CEST)
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id B0A5D19F733;
	Tue, 11 Aug 2026 15:14:16 +0200 (CEST)
Authentication-Results: smtp4-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=zxSPubJX;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q6ZbQvZiQaUnf6LKHUNix61p0ktbp6vC2ZVjEvj8POI=; b=zxSPubJXWKAIk03B5D6U8Sz9hx
	O3hV76FlDiUY7NaLyxYovLfCIT6+lFa5At0rEHyWxBMhBnQAeqqiBQJt8EPgis9gJKrpOiJcnLjus
	yV47EkImadPHnyiiT69OvPUXCphzMgY8rX4tN9meW0QwuMx0p6YmmPZni8uroGm02wyI=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.98.2)
	(envelope-from <guillaume@morinfr.org>)
	id 1wtmJ6-00000002L6w-0wQe;
	Tue, 11 Aug 2026 15:14:16 +0200
Date: Tue, 11 Aug 2026 15:14:16 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sashal@kernel.org,
	Zijiang Huang <huangzjsmile@gmail.com>,
	Kairui Song <kasong@tencent.com>, Hao Peng <flyingpeng@tencent.com>,
	albinwyang <albinwyang@tencent.com>,
	Baoquan He <baoquan.he@linux.dev>
Subject: [Regression] 6.12 port of CVE-2026-64415
Message-ID: <ansgKOOXi6KE3oKf@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, 

The backport to 6.12 (commit 60cbe67d1342f34b66df1c2ee328e3cd333767d7)
of 66366d291f666ddeda5f8c84f253e308de3e6b55 "mm/swap: add cond_resched()
in swap_reclaim_full_clusters to prevent softlockup" seems to introduce
a regression.

The cond_resched() is called while holding a spinlock:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 883333a87a45..552df432c37f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -767,20 +767,21 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
                                        offset += abs(nr_reclaim);
                                        continue;
                                }
                        }
                        offset++;
                }
                spin_lock(&si->lock);
 
                if (to_scan <= 0)
                        break;
+               cond_resched();
        }
 }

The 7.1 and 6.18 backports do properly call cond_resched() after
releasing the equivalent lock.

Simply moving the cond_resched() will fix the issue:

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -770,11 +770,11 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
                        }
                        offset++;
                }
+               cond_resched();
                spin_lock(&si->lock);
 
                if (to_scan <= 0)
                        break;
-               cond_resched();
        }
 }


HTH

-- 
Guillaume Morin <guillaume@morinfr.org>
