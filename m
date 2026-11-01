Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557435;
	b=PQx3Mt6PklEXyJLbLvwUjzX0m1t2o0LSiCKfW8n/qFDwlQUCHucqzsvAJGCs8Nl70//s
	 mB9CPrC8P1lHxbgRLkhi+PTClJBwleeCojutzOnXY+41H51XkpWZ0KHloH/Xcbudt59XS
	 krR2RjrOtcAbjL0my0hOOPqqYXxEEjFVSeXPG0MYvf/nxgdukVWtTqsUzzQ0PpOQAbDhp
	 XN9uVbFu01ReTKH/pzMe8jtZmj9iHBAgzP8NP8AW3bJuA+XnjtGqg4GvGUhFPI8vucSkM
	 P/0vFShVHK9srty9j/m5OlbMoccVkZfXcWDrEC+D4dlofW5rdKmG3Xpas7dPMGd53CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PousPftMuxge1de4JgtYSbXjOqqZ3UAm2KBK0fUdmuE=;
	b=5k3O7BU2m/28/8IPFV+sQqcmgxFsw6AwLCE0oGJYTSwAEpLi4hn6CBpa61Za2rjDdR08
	 WZPT4chQfVeQUQikVT1xtSHOYLkeblKgX+uuf7fkLyHumCXEl0syMWcproxFAVftuggG0
	 XLoCF7ifPduSOuHuujyI8QXroOETW/iNt2Y4VQ/aa0W8xYSRlEap+u+ee88xIoWE0QFYH
	 O8rLpg+KDDxcuotex78WP6e7Z68lzr3zeTfFeKsm9TP5qoD2Y9lllFJxVKvIeFJGTFkG4
	 Zjn4bX/kR8a+Vn9NcmtckNr0cZUj91GaL7wj2ByytztEOmwG2/YvTWgv2BBWMaVC+1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSFaeFYu;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C9606A327
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 18:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D1C9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jSFaeFYu
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a18fc7a38so3493348eec.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 10:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793557434; x=1794162234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PousPftMuxge1de4JgtYSbXjOqqZ3UAm2KBK0fUdmuE=;
        b=jSFaeFYuK/zwL+ige/xGHmU4b5Ji2VCn1jiK5QiS2ac9ZOVljLBgogYTjdJtZeAvVe
         E6A/aFGnyDJZAEicrf9Cz4yQfDorfvGJTLIMlqgPpIh0Pmcd3hcnkQnOxitpF2/597lZ
         o25RBf8S7etBYJcRT4rputGTabU14ly7UIyemBAprUfCiAtZH1ssDoRsuJoCFz1Gwlzu
         sM7+6oyQuztxUNRLzhFhXTaTV8an2LUi69zW0xRIcvs07fgz6g5feOshuDRA5c9hztI7
         rQtG7FiY+Il4e61X0NIWWHRxVetattD5Ft+mXkSQ7rJymROdkFcR3LOX8lNDZXZiKcxr
         xD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793557434; x=1794162234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PousPftMuxge1de4JgtYSbXjOqqZ3UAm2KBK0fUdmuE=;
        b=KR0mNz1ieq6RmlXQUCISV+cgCteOEaBLfIHJT4QVyuWyQYNSVP6sjuJd712Hjxzk2l
         RhrBmiziteqlPOyOUED+2BTSUK8M5RsGvN9GEsxSYcYMUjaXgMtdlNbXv662z2O0T6sJ
         TkkAo/5/vr3ilCA0YOwa41LPtou5i7VCGEFkY9vwlcKR4DKUwoCfj6ddmkYUnHrOhLkO
         CfEQxn4jMGhQx8SOShnJonxuP3AcStyYMCyckSaHuGjvTilfWkY2YbSLzOpwEyZrk/Dv
         410XEi4Mj+ZlCmBd4p+IyjzTM5r8PqLmoUy2EZZm8pKw8eDjhrQsIecEw552iFxMMEn+
         1DFA==
X-Forwarded-Encrypted: i=1; AKwUvBy+C7Z2px9IaSIXwhAfzuLzBHJsNaG80Wv0qBBttus+QPoeXsyg7b+zSBQ7+qccpbegdypq4h0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUUR5Lfb5+LmwOpQkeA9ww15aiInrS1jdp1xmvxNaIfa7FTZfv
	Lgl2Zj4y2UFyww8RtpXd3T+JRa9KeQZlpIuyRYTkHHL6+ItxYgf7Lco/
X-Gm-Gg: AYBFou2/iLmXA+ykSCDZZ/FpiLC21KHIynp5obzGgITNaZR17xUFw0GFsCu4C+plo2x
	HcYrBO82juGwLvkqKLicgRpDH5wP5qStAug2fS55wP0sicsZQItMOS/33fnE5RtRzOV5oxtl/d5
	qG9OZYxOJgzEH78Uoz0D2+L9Bemzubb22foYwm/uIdvvDtwXZq+NlTFYUX7m1VpcFrT8wXWQzSf
	bbh9M86od5I0DYnnB7UJi6qAZKWW6JN1NMab6w05nwy3o642AdPQmE7rcTYp8qeZaNkyWemtzJp
	l+Q0Bj39VoqmoBfsITQmyuCUybjhh3XuZ9z9D7ytYlS3tviV6SkTrcRiS5inE7FoO0llkjxFXHK
	8IEA7vDg8hkzHjYBrHanCAkmAYdaheqlbGDRch5x2qV1L4iixyOVQR1gPDmi88w1Ik+N9SWsyYJ
	T+SssU1ku/wrNkYrmhBFjY6owMlQvuNQ3R1LsOhba8k00h7Df4bvYWdiFMkA7waYQpK/ufN2Oti
	G7CjFJaVo7V36V3ibtgBaNZSGBGYs0+h1ZWOSoxNVhC/8FR5DJpSxtpzyau3JMPlK1LuINTGIKW
	XHmSMNo8ynWfhtL4StimVlxDZKek6bKO9nHhGIV55bGxlw+l5nF33M6zLPKO4Lz5Eg==
X-Received: by 2002:a05:7300:e9cf:10b0:369:f126:9ce2 with SMTP id 5a478bee46e88-36a42481f39mr14812550eec.41.1793557434277;
        Sun, 01 Nov 2026 10:23:54 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:50b9:9b10:1e19:1f0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm27298976eec.12.2026.11.01.10.23.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 10:23:53 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	ast@kernel.org,
	tgraf@suug.ch,
	zirajs7@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] bpf: lwt: Free the skb when bpf_xmit() fails to expand the headroom
Date: Mon,  2 Nov 2026 02:23:43 +0800
Message-ID: <20261101182343.17991-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When an LWT xmit program returns BPF_OK, bpf_xmit() makes sure that
the skb still has room for the link layer header. If
pskb_expand_head() fails there, bpf_xmit() returns -ENOMEM without
freeing the skb. Its callers, lwtunnel_xmit() and then
ip_finish_output2() or ip6_finish_output2(), take any return value
other than LWTUNNEL_XMIT_CONTINUE to mean that the skb has been
consumed, so nothing frees it.

Each such failure leaks the skb, together with what it holds: its dst
and its charge to the sending socket, so the socket is never freed
either. The other error paths of bpf_xmit() (BPF_DROP, an illegal
return code, a changed protocol, a failed reroute) all free the skb.

Free it here too.

The leak was found with kbound, a static analysis prototype for
ownership mismatches at kernel interfaces, on v7.2.12; it is present in
mainline.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings. Run-tested on QEMU (x86_64, KVM) with KASAN: a route through a
dummy device with an LWT xmit program that pushes one byte with
bpf_skb_change_head(), so the headroom check has to expand the head, and
failslab limited to allocations under bpf_xmit(). Each of 10 pings then
fails with ENOMEM. Without this patch each leaves a raw socket behind
(RAW slab objects 6 -> 16); with it none does (6 -> 6), and nothing else
is reported. Without injection both kernels go from 6 to 6.

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed and tested them as
    described above.
    
    The runs were on mainline d135ab453a74; the code this patch touches is
    the same there and in net, which it is based on.

 net/core/lwt_bpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..dfb2f9253e81 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -304,8 +304,10 @@ static int bpf_xmit(struct sk_buff *skb)
 			 * made before LWT xmit.
 			 */
 			ret = xmit_check_headroom(skb, hroom);
-			if (unlikely(ret))
+			if (unlikely(ret)) {
+				kfree_skb(skb);
 				return ret;
+			}
 
 			return LWTUNNEL_XMIT_CONTINUE;
 		case BPF_REDIRECT:

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.53.0

