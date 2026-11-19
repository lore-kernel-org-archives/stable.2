Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061562;
	b=pfjyjZYAbva6nOc/605cNt3+VPjCu1gL9YAhzsnbrknQuvYgEUKCZ6I+gk9swmr7soNN
	 7cf1yMo6s1wK2sYtpAETaDSFaXHB8/J1+nMUvdJMydP2Wh4E+0s4N7slBfo9MCkEz5gXz
	 NV8s6uIncSoW6R8T0Kw5V/GxKt7ueqefwqCwaMFItMYAtBvFtEEorQRKDND2cpQlc8SlJ
	 x2xjM7xTBP459s1liXDRY3TnA2C19sGdMFJbxf5Xe8C335XU7EC9wbcd2sPZaVjAM3RUG
	 /nJHwuaJJ//xepqz8dHlFBGGJqTsFBw4o+N/cNO1+KlpWW67gb/a1fHpz29+fkGhn6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061562;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9i2xSNVqrdCkfoxIYuGVvU1swaArXTrdncn/noLGlnk=;
	b=ECW/wyTNkVMhniN38DX7kgMnDa0PYlVrLEWzFUj29bZMYFYfZvQN6pyWGxOwi8PKV4/h
	 rh5VGALolIfntTZgj55IGX1VXrSNLaSZWDhC4YxmwYlwIwi+M7jIusuKZGQtUN208ID0O
	 UXLg89zTCe9lap+pKnza1eM1+TccZEu+v8OxvqGGRz0FsFiBdiERSN5Us+h/YqtX6MHR/
	 dv2jYe7l/ibu3PtsWDCOTQloRwSCEK6+XNWeYz+HcJ+0GXfP+VdRKUGCVzXFN0YZbkaIu
	 YxiYMABeZmlF7Vbbq/BRdN1SZfTR2BSWTPqkLcqdpgg1KnheSLetvgZ0oDTUAhmRHNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=eCbUE52y;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D460A2603;
	Thu, 19 Nov 2026 04:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B25D460A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=eCbUE52y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795061532;
	bh=9i2xSNVqrdCkfoxIYuGVvU1swaArXTrdncn/noLGlnk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eCbUE52yh4rzRfxMpVYueg6rlwt8f2hS5yNUpjXP1uR8RZrljExHtrUfZXmvg7aQt
	 oCg4lDWirEKZVAKph8f89E5YNmKn7svxNjvSjpo/n7EGGODpmB3QL0uLg5QQkRZEzV
	 7R/EzYGsBNapmlNPUOYgiVxoQL2V3f7eezHq5t/A=
X-QQ-mid: esmtpsz10t1795061514t53da4054
X-QQ-Originating-IP: d/4tuF11XGOj10HNJTbqcdVgReHSy8ZOCdXEKnz4xCI=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Nov 2026 12:11:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4520981733334392773
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	imv4bel@gmail.com
Cc: martin.lau@linux.dev,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH net] inet: reject unhashed sockets during timewait purge
Date: Thu, 19 Nov 2026 12:11:14 +0800
Message-ID: <1595ACC3A3D11BB8+20261119041113.3514099-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.47.3
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: No4GWyI4cWt6Df5bP2kXmZVq/n+C2IUuPBJF8fu8tufByM2nUw+PMfJt
	KZTka2mvCe8SHfhRf/7C2hZP/LvZ+ly09DubesZVOuGtTobsMj/xVSKNGpBBvfQkcidhYFU
	IHvlw4B5OjUmZvCh+Wmr5oR2BMlWAk6zaiqKhndsvdar7+AaLF5yg7WEkXH7c6OuXDUnOfL
	jvUDMkatSrpb1YnNwdJUmQooeZtL29Tei+2m7l13OJCu/4CZGdIIyk0pMIf12L50MEpT1W3
	grHRbgNpwP4bx1ETAvUuxPp9K+Dls33Cn4mLUIuqblyKz02CkcxnH9O1RoLDhRd6pNsFne0
	SD9Zc13WL/QCW2lMIzldyQUH3OV/Uj+jr3njLoU8A37fqvczZjTJA85wq1ZJSja2YkQ8X+Z
	RdOXjmeFMLt+2dpla4lQMbj8w9B4FGjrRAIP2CYPHq98205dDxRGPW0fWQx8Nv7d3DiZLUO
	lMby7AacTTqyJWFBhaKcLHTZFcwLobCNBRcRIJBfxLpgAjiwIn0qK/ydra8uaRw8oC+1d4V
	68jMtMkUbLvpprJcQIv79cLFXVstx3TcX5i9+/1iXH6VyUa6Gz2QCRudHW7aXOvBbnEVOQ7
	2qlH+AIP8rbVUvGAaLH/RKhK4qV1vFj3pflrkYPJO9Nec2m4PWPglj7J0na05i8BHwL7yIX
	xPa727/Uq5kdC3A7VueZu70U6bE8C03G1esWcC+H3sa6XWTMFVdXVzjpOafEm6Yy0DdFah7
	0kuQgwzDSY3A1zfo5QPultxcxnax3ihinSNF7vn//lSNueI9U4Q02206BTERD8MBXVtRHsq
	1Kns9PSWbUlv51lgUGiYShidS8+4pE45X/qxLDwE9BT8coqQtFviphx7Cojydi6xFviuGb0
	8RBLl2wbFe78DS3TnFNBXvnTIZuYIerACD7bR21RDCy3Fx+Raq1e10PI8zXKxRGyWra+S6d
	ZYubBOXNHuAxmpBH5sJd8AOIGuIfTf63JxPpXDYox2cofrWkNFAkxKD4SNsvNQ/lx21Q+iT
	lVLWqZBKIh8qVAcVTQ5XinkZVwT+GGhatnqAJnQc2byx331QpeTF+C2EFJDp8=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

A shared ehash can retain a stale pointer that is recycled as an
unhashed SYN-cookie request from another dead namespace. The namespace
recheck alone accepts that request, and
inet_csk_reqsk_queue_drop_and_put() can then operate on an uninitialized
timer.

This is the inet_twsk_purge() counterpart of the validation added for
established lookups. Recheck the nulls node after taking the reference.
If it is unhashed, drop the reference and restart the purge instead of
operating on the recycled request.

Fixes: 4e2b3ef19e0e ("inet: reject unhashed sockets during established lookups")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/ipv4/inet_timewait_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e256c55ce9f29..5601bd03b1382 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -333,7 +333,8 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 				continue;
 
-			if (check_net(sock_net(sk))) {
+			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+				     check_net(sock_net(sk)))) {
 				sock_gen_put(sk);
 				goto restart;
 			}
-- 
2.47.3

