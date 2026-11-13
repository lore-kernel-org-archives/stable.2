Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556444;
	b=v1jYXGk+Qy1Hq7X/ZOrWlCBeFogNBLL1rqRtPRE+xd/CNLDWM9L8mmvQ1o09ee2Bf+wY
	 oq0Apu4MeovKucRH1tUSWC0l4M4P+Ctr7BKl8H8zARMEMYPJy8PjT/hFvnb1Ac+xXhwN+
	 zqjJ5NkSQc88wLuKmJXcgkOoKh0vjab0diqe7u6rx8RVv5sNx/3AmhuPBnbCY7UT2CsFi
	 VkdeR6CXaJ1VqMGsc59ExzWpQkU4zmxEsVICdSdqZrgAFNA4+5Yd64wpIFidSeGgSG82J
	 C104NkaaV1QBAoWGTCKuHS11CTFpNOX0sZGoqBe2+a71w1ZATEOAz01MzOKW1XVfJwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556444;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=ctOsZN7/duqyJmngVLdUYndeB6SKyXUmBJ6YbYA/85g=;
	b=zNpyxCVOOXLsAYWwM+pGglmEVoD5ELZm/0pvGgKZBjSJK6b4FBn7on14S2X2T+1ggdkY
	 5aM98hXUEvp9yBqL8ldbIVYkvpmIdc7ZpY+5PZl8c5IYO1WUaW5DA4RzjiFgRyWZab26n
	 V3MJ9qL77ta/gjnKWHyvpa9cbmekiBZP/r33FuUBay5DG/8MkI7YnFbkB7V1L5jJ5BpG0
	 JrqynIsi20F2yN9mpXUAbbD2qY+enfqsGdE6HRtbeqt7TWp+jdp9zZLb3atVlRcf9gHS5
	 6niXjISd4Ve0SWlacFRdR2poURGqm/Ju57LbOtDJk8pbPhBwm3jQdsBW34R2nhiQ+OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zoS52bf0;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E60606A32D;
	Fri, 13 Nov 2026 07:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E60606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zoS52bf0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=zoS52bf0RYzxMcvhTiICqydXJsuqXkozfT/m9NQTVvkC/Yrd2YcvVluqIu+pPHLtZ97VnV2nSo2/g
	 4Bh3/byT80mgrpHz/F2Ib8/UYE/S14F2kJypRfaPiVkbQ/t7KtznvYc45tZufZTPhOYPvEOwvGGtmQ
	 oPm+98dUMHA+/FYE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af6c215af3-e7259;
	Fri, 13 Nov 2026 15:53:59 +0800 (CST)
X-RM-TRANSID:2ee56af6c215af3-e7259
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [198.18.0.35] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af6c216d3c-1d73f;
	Fri, 13 Nov 2026 15:53:59 +0800 (CST)
X-RM-TRANSID:2ee96af6c216d3c-1d73f
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
    edumazet@kernel.org,
    ncardwell@google.com,
    kuniyu@google.com,
    davem@davemloft.net,
    pabeni@redhat.com,
    horms@kernel.org,
    torvalds@linux-foundation.org,
    linux-kernel@vger.kernel.org,
    stable@vger.kernel.org,
    yana06070@163.com,
    netdev-bot+sashiko@kernel.org,
    jiayuan.chen@linux.dev
Subject: Re: [PATCH net v3] tcp: fix device binding after failed IPv6 connect
In-Reply-To: <179451033353.2199510.15626724662436845169@kernel.org>
References: <20261111113455.284747-1-yanxia@cmss.chinamobile.com>
 <179451033353.2199510.15626724662436845169@kernel.org>
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
Date: Fri, 13 Nov 2026 15:53:37 +0800
Message-ID: <20261113075337.101230-1-yanxia@cmss.chinamobile.com>

Hi Jakub,

v3 restores the binding on native IPv6 error returns from
tcp_v6_connect().
Ordinary handshake failures after it returns 0 may leave the
scope binding set. That is pre-existing behavior.

v3:
https://lore.kernel.org/netdev/20261111113455.284747-1-yanxia@cmss.chinamobile.com/

Would you prefer to keep this fix limited to synchronous errors and
handle disconnect-time rollback, including deferred Fast Open,
separately, or cover both in this series?

In late_failure, v3 restores the binding while the socket can still be
in ehash. Moving the restore after tcp_set_state(TCP_CLOSE) would
instead overwrite a binding set by the CLOSE callback.

Should the socket be unhashed first?

        sk->sk_prot->unhash(sk);
        WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
        tcp_set_state(sk, TCP_CLOSE);
        inet_bhash2_reset_saddr(sk);

This keeps the restore before bind2 cleanup and lets the CLOSE
callback set the final binding. I haven't tested this ordering yet.

I'll wait for your feedback before preparing v4.

Thanks,
Xia Yan


