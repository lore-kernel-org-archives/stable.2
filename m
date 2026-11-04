Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783874;
	b=DiRNjFPqSn/YCxzX5hQAp9uzCDTZBJtnExWncVTCFtsCXXebPQZB/x/Qd3GrXqUVNJch
	 pqzAyA+45utjZnKebus8NN8D4sGO6S1z8Kw56SzvWK7LfHAZubHYO/fQNy4lqZGgM8LTR
	 5dnAqnf0bbZNcA5kHUd4Mpul6bftRtjOQW3BwLEPHMJX04fi/Hi7PDDSGqtSAZZuUZgND
	 ljVK/ApOIVdcTBdemxTnP0VPDVxDd7ZRAzFNYlwQBlH1QYBUUBmb9UPdXwYyqWvcUVxsj
	 6OHd3Skspz/9Tc3REnw1qt1C+1qJkF7EiZu5UkVWfRc11Qnm3e3Wr+PWLvLRU+E8jWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783874;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=REYCwLzVTyXXiLUH6Yf4bo3GwRsHUh3qcFy5GtRjoz4=;
	b=KMVXm/CHTj3mcIKZBsE+Lv6dAMo4bNAWaDVl/wJuvFUsmXJJc2mxbCdh+HUqU6DUDc0G
	 fsp1XRPbBTM76PRawqRzVLVQbNiradZhx5VK3GbYc9jZjno0/XP3ehbojY/V4oZwQOQr3
	 lC3MIR172hIr5R/7g4S19mOzGRR6paTvlkSE9eoiyB2yMpBwxfwtJx7sI/gJa/1HjZgJf
	 1LIHVuUiJdq6QJLYz7K8Xl/fQdkUUsxu99QpmMcrgI8YyDDSvKFREOdc2n8PzBc3B1MSy
	 MkqJa87F4p4+PmWWOKh3GYRc1SkVEzMb8vu4JXWGR/K9TxfDarVU1YrfxyW0OqekR/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=o6Gi+ZDD;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED2606A328;
	Wed,  4 Nov 2026 09:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51ED2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=o6Gi+ZDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=o6Gi+ZDDRVp+f5lDwn18+MvApvDBwFzjMcuztqFBvUD18adJ/qZ50fJ7cAbjR+txLuQdAs3V9kqb4
	 SU6nvLkSnMoAlzI6OmAJS36v7kNb61NG3+k/mJu/8Pp16U3BrV8xWhn5hEudCkj+aA1tZk6G8EV0yd
	 dRdnOJfwPSbgXkdM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96aeaf83eeba-a1e2a;
	Wed, 04 Nov 2026 17:17:50 +0800 (CST)
X-RM-TRANSID:2ee96aeaf83eeba-a1e2a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16aeaf83da4d-1d1bb;
	Wed, 04 Nov 2026 17:17:50 +0800 (CST)
X-RM-TRANSID:2ee16aeaf83da4d-1d1bb
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	willemb@google.com
Subject: Re: [PATCH net] ipv6: fix cached route reuse for SO_MARK control messages
Date: Wed,  4 Nov 2026 17:17:37 +0800
Message-ID: <20261104091737.13469-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179371875338.488856.4546363285391899557@kernel.org>
References: <20261030141435.779302-1-yanxia@cmss.chinamobile.com> <179371875338.488856.4546363285391899557@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the review. I reproduced the race with a test-only pause
after sk_dst_check() takes a reference to the cached route. Changing
the socket mark to the cmsg mark while the sender is paused still lets
v1 send through the old route.

I've prepared v2 to record whether an SO_MARK cmsg was supplied and use
a fresh route lookup for those UDP and ping sends. With v2, the send
skips the cache helper and returns EACCES. The cache check added in v1
is gone, so the comment there no longer needs the proposed mark update.

The series also adds connected-socket cases to cmsg_so_mark.sh. The
same test fails two IPv6 cases on baseline and passes all 54 with the
fix; the separate UDP/ping route checks pass 50/50.

DSCP and flowlabel remain separate follow-ups, as discussed with Willem:
https://lore.kernel.org/netdev/20261031033159.2712-1-yanxia@cmss.chinamobile.com/
The other port and source-address cases still need checking.

I'll send v2 as a new thread.

Best regards,
Xia Yan

pw-bot: cr


