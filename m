Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574020;
	b=07p/Iyml9rH830jSNSimYzf8fC5HtejjyhmK7mkg6LoZj0dudG32RYhxu2arfb4V6PxI
	 hAZ1myXEOZG+zja1RkutrBblpV/P8kAXAGBMQBlWHmpwTFxGcLdfR6k+wv5twza0xVCHZ
	 b0jyfpY8HEn95J2pJzsxIq5rB58+cg+BMWaCz8MOkETjgQPllmnjeM5vHSxMdCR93mI36
	 vCse/uE/VeyQq5BopcIUu3D5QPzK/7AmRfbHgCEWFxMjqq5Ke7bDpsu6ZCmbTrIEVnCn5
	 fqH01afsjtS2LNnYNgQ0AV+gksaNTcGFOiLxgrW8GbFcfTGamh180tvmlG/hiYKLLXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574020;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=a/ylpv5zb3YmJmUzNYOF/GvkMn6cziKXWyWLWdE7at0=;
	b=R8bOwAw3WUsDWFqM7dq+cNKOLauU+06Ytu0GczYo0At2Q0yIneb/i09jE5UHe3Ai3tmX
	 rT0UwO0E8IsQQa+I6Du/h1AqMMqbDU4Iwdco5eglRGS+5pthvmA5zLDstXBMo5YIIsIki
	 VjvjXUvwivpGAMZEXDr1pY+lYJ8upLOXFhKeK12nrrpM/2CdTkyAlwfNQ3JmGGoBZyxQR
	 GoWT8vfK0S3M432ORg0UKpBaBlLa4J/8iDFaARR7Lio6ns6Ixzt84B4pta4nCngqrywTH
	 dobXH6RPqEjZ5GjMBolEnIq1Ol8MVcSust7tNV4FF+Fna2/9vlIAiPW1qFMWUZ6XBKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Icd2MpPd;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F51606A321;
	Wed, 25 Nov 2026 02:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F51606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=Icd2MpPd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795573970;
	bh=a/ylpv5zb3YmJmUzNYOF/GvkMn6cziKXWyWLWdE7at0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Icd2MpPd5qsX9Rta65soAoSQD5vvyK4E4J0mdjZSVyHLvYv/9GqPKbJJE9Z86Y0z2
	 xaKnA0r4vRLsweaU16Wcbi/PUuKcM1nCmlzsK24ycgiRZzelXyLZzL0jSqrqnRqn8t
	 VdGye0aIe+aQ6qZdEzc2Pet4BAooaCMkNhOCB4fI=
X-QQ-mid: esmtpsz16t1795573951te2d1802d
X-QQ-Originating-IP: VeRzoiOYtmm3VRPJOf5RgdvHIHHqXeNfLu9FkMQUW/w=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Nov 2026 10:31:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14082261952295443755
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	imv4bel@gmail.com
Cc: martin.lau@linux.dev,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] inet: reject unhashed sockets during timewait purge
Date: Wed, 25 Nov 2026 10:31:24 +0800
Message-ID: <F92442AF3AAD7C83+20261125023123.4185642-2-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: ORygBKzmLOEK4HW+6/ELqV/fVl6R3oDtWVS45TWsyF7VqiAFb22veCo1
	Xm0sU4haoQxZPnbBh6RKBXQg0Ikug1mcYn24U6CFLL3rJSr51ZQHv3KRPdthDwLFDjXueBM
	HjHkZ6M4sWkNmCOfUwc2WOWbcFU4uFieUwrqWVgQ/zP9ss7J4wyQL3pG8oIrMMF97m9hP43
	nkTe89DHwXHdXp6EaiULm2MEL3bLVOCTCmz/wJkyrAZGv/xk5HPylJS8ow8LA6AgrzJWVUN
	tzjT1qclRxzZkZWcnU+EQLJOxDy8OPDyEFokx1WbQuJA+tfnoMhWVFmp7oPWAohQjz95SN2
	3Ip+nPT2fRcWurO/qOWUwhRiUppXlSAGp50gj1Evbc/NqNU7ZB8rjK9j6CO+UNnXdeQ7H3Y
	r21i2bFqyjafsnJqSJOsDPUKMBnqs++J8gHn141bhvxos4LdnlGqDaMdwej4yPS295l9Uc1
	T6HsR6FgDcmxrUYGG2mgRgCQAHPOgzRZUmnethe03EYRaerGeNcVw7H4w14Xa75mIu2hQXm
	Le8l+BYevkK/xjcXXtTH+ge42s5Qf8McGhwl1gI9QYtlgrQ70ttMmbnoqMPtwt2xeAPhmr7
	UnrVj5Ca2x1QW+CXlavdjn7MhvFZMNkRxN2ctAmEEkPevOKLtW5RZLXMgNlpjmPIuHEi/ll
	B36X+34jT6Qh9TMkLjq3sDYSqezjx80Sh+Ud5ks2ageCzR9dR03ZGDXz0oY/0W/xttWvB8M
	cmMWKBGC+YAQZpNNQAQnkJBuIkuM7A1nWJ6l/NK9oDwEw320n6kCTtE/u4PZvRetqPnRsi3
	aNYNxAKVLSvGj6sermm8VlpIXVRYic9p2CvJC8CsP5dEyARp7/pUUZxBizJHixI6CZqT9iW
	6rKQKzL+R7E79TmmKfLrl13plu7+3MMU9ugH1BUreBALEM8Z11I+BKJ0fYFgVyT28inmX/w
	soXziauRuHEYjthLBWpn24Br3cwP2oqEn5KkqR6CCGnGVwcjzVzyU/n03nSA6TD+GLXAuQC
	Tt0ecH9GhkUDePNb10HnsTJ83AXK3tCYrA9kdF93fIwia/kKENYr/zrS+1jXrdDRKcLtP3Y
	C3ynIMe064muAshXBBlW9M=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

This was found by review
commit 4e2b3ef19e0e ("inet: reject unhashed sockets during established lookups")

Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_purge()")
Cc: stable@vger.kernel.org
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
change Fixes tag pointer by Kuniyuki Iwashima reviewed and add the reviewed-by.
v1 link:
https://lore.kernel.org/all/1595ACC3A3D11BB8+20261119041113.3514099-2-guanwentao@uniontech.com/
---
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

