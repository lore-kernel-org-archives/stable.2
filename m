Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D3233924
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785044020; cv=none; b=K8vD1zWJIROyLUMu/KI2xxinZFqOMHJ/yBuiEC6JfC2q9qoAhbwKPmzizy+kbbIWCrs0NKOfyPJQRgnnRg3u5+Fd9L+6GMaCfmMdG5ARuBjHuV7ip3sr90Vpb7/NGMI1LICxBJ8q4xsJpWP8wKC+L2D4c/TOZ8Hpq8ljIrcETdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785044020; c=relaxed/simple;
	bh=47i/YXfixIt7e5t5Gu6byp5P4Erdmj27ukrh+PELRgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0H7pqrh9aeQ2rFDB0SfeRh1sP1PQqpQah+OYC/p/jhbClnKJjaGgffqQAgeiuCU2UPzl0jx8JK1A5MFBwNix97nEAVjaMZE5JXwzVDzW0s0vUTp2CuHV6mSR05Kd8xgSCAOW3NFzOQRlwZMv2ZZo6YWIGONwIGzuqwH0VzCCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=Z76QKIgA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="Z76QKIgA"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1040449a12.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785044018; x=1785648818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0FA1kd0s14T0zTfOo2W1mWfRhLmW66jk1mDOW/wW+k=;
        b=Z76QKIgA/3IQ7HqQIWiW4cqgSw5gRhmVSii5njgmmoOGd3s940gamvQ4IhRbLcqzSW
         p9FqyA3/Q4fP5M/kccC3S20lli8TOKFNOAXS6D8tq3iX7LyvUEjbBpzwDtjrMMvgLFPa
         5VBG2AeAFrQgo7/jUf+AgcxkJKR324D4kALqZ+733XXTddki6A+VNjR+KQPf8JEAC0Vt
         0GixLe5eOvdWrH7iVBMdd6bp8jpySdvATHdY6XSSHWfV9qzavcDGO4p2Oo0aY7xx7z6b
         0mGa1dfTNygGqIFyUngR/TuvO3DLCf1FNMwRxsV6tJCdQvMTMebrVoEiqJORnrlZuZlj
         1y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785044018; x=1785648818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0FA1kd0s14T0zTfOo2W1mWfRhLmW66jk1mDOW/wW+k=;
        b=FwiDpRugKPqDch8djcijc0RKXyo1RfxEGsEYUhOlahg63uiPwl+4PxsF1D0hL+nz49
         1oK0zUPkGdTKCLBAJRloJtUusexReFPCUArPLuA6sl0K8VujRVNF/GEIn0c+GwsBmmSB
         kAhiAbCItMyVVu2jZubAPJ/rYCLm23Tt0MD/dYVxz1SafSvxm28G/hyQP3AJI5WWcVlG
         JDAk41fKgqKjOPC4KXngut973ewYRNfnbTrEzPV40Y1XQE7pzP+rAYWoyf6CcoiTKyA0
         WyT8+RLr+0Acj2JirIaQ22vf/oLRXCc2TnxL82HtrwySV8HLSiVFJB59tUOF5gY07twT
         UorQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiRfGeaWh5sE9XBX1QZOhODv5WDnpJ5luhsrbbHxd8VwH8l4umqm0qT7NpIqAPXjf1VtM3Z4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOCIhBmmGuHQ/UvkQznkczmR0r/NHSAutcGeL+7B3YODKAdP+
	IKksfjP3iE1rzPIsBJxJTXEhbOhWSj0MeT6dKMi+yzG/ppguwHXlfjhCH7dAIuRNtcs=
X-Gm-Gg: AR+sD13GJTkKK7lN4h7efkHnkVAd8tKOOLtetd+vv+JdEOiOXBSEMSPti1JYHYY6FE3
	fZn5hBBEieWdkQZfxG5CGkm+8T6qNfnINHUfc4SrP9/Q/jCmHAdN1bSB8ImraLN6zaDwWsv9pEh
	/nrsroF2WMB3ZrNqg1Iewvse8jnVE7jFkg03k8XwJlsK47Bu70HBo35jzCuQA1A7q5HMKIv9YMC
	jrLf0KDGak0deqE9Z0BysXcUGFCpVNB1sUsggXLTYVkxxJ9hpOCjfDM3TbWcVGpVltzQieHwn7q
	TV5Lv/hyN6IXfa3WLp9d+iwPLRFv+GQy4NjPT1kWEL7E8pupzXOHOLPayiFxwkpUXv3awDm4thP
	1dWuzClmeUt/YNZIGjSUqwqMcnDtV/UwVnw6R9Ofv6WtyxOhzxPpKZjesFyIeagKnK13+PcN7Te
	S2dAmJSJu6H3gQ2XLF0W7ml7huPkTimFN2aQpoQnWbop3zFmtgGR38otS7bGcetWFe3ugylNE=
X-Received: by 2002:a05:6a21:a347:b0:3c3:bee9:8eec with SMTP id adf61e73a8af0-3c67da2e421mr3837000637.19.1785044017923;
        Sat, 25 Jul 2026 22:33:37 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66c9dd2sm1785092a12.27.2026.07.25.22.33.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 22:33:36 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org
Cc: ms@dev.tdt.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
Date: Sun, 26 Jul 2026 14:33:30 +0900
Message-ID: <20260726053330.41736-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x25_kill_by_neigh() walks x25_list under x25_list_lock and, for every
socket bound to the dying neighbour, drops the lock to call lock_sock() /
x25_disconnect() / release_sock() before re-acquiring it and continuing
the iteration.  It holds no reference on the socket across this window.

A concurrent x25_release() on the same socket can therefore
sk_del_node() and free it while the lock is dropped, so the following
lock_sock(s) operates on freed memory; the sk_for_each() cursor can also
be advanced through the freed node once the lock is re-acquired.  Either
way an X.25 device going down races a socket close into a slab
use-after-free.

Take a reference with sock_hold() before dropping the lock so the socket
stays alive across lock_sock()/x25_disconnect()/release_sock(), and drop
it with sock_put() after the lock is re-acquired.  Because the socket may
have been unlinked from x25_list during the window, restart the walk from
the head instead of advancing from the (possibly unlinked) cursor;
x25_disconnect() clears x25_sk(s)->neighbour, so an already-handled
socket no longer matches and the walk terminates.  This mirrors the
reference-holding list walkers already used elsewhere in this file.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
Reported privately to the maintainers on 2026-07-09 with root-cause
analysis, a PoC, a KASAN log and this fix; posting to the list was
requested as the follow-up.

Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by x25_disconnect")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/x25/af_x25.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index c31d2af5dd22..68c396dc4307 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1770,13 +1770,17 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 
 	write_lock_bh(&x25_list_lock);
 
+restart:
 	sk_for_each(s, &x25_list) {
 		if (x25_sk(s)->neighbour == nb) {
+			sock_hold(s);
 			write_unlock_bh(&x25_list_lock);
 			lock_sock(s);
 			x25_disconnect(s, ENETUNREACH, 0, 0);
 			release_sock(s);
 			write_lock_bh(&x25_list_lock);
+			sock_put(s);
+			goto restart;
 		}
 	}
 	write_unlock_bh(&x25_list_lock);
-- 
2.50.1 (Apple Git-155)

