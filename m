Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580A3C4171
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957123; cv=none; b=tdfJzIxFEGTxnR8Ant8nZnopoRHgDZgCXmAT2aU/jxQwZfcZircICDoDGjhrs9VtCCHi+SjvtNieKxZCNFiieNVEwXMXnu13aib/84UQ585kzf772vTmZ+BPRKTHXqZeXFXKlsu5tHJWuYa+M9LqkF4XzXrnE+him4ZkVkEvg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957123; c=relaxed/simple;
	bh=4BvH+ZY7UqiOZgkyYTVq0z8Avw0frj4tIodrDtIq+14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cR2gNvHASaCEhHFfUZBbpiw4MhX3ZRohW8UFUTtz+JbYf8ghsQWrAiZuoOla/DeY76BjjeJzvL0JDS20Nh5q6mZZUphwT1yBKA5ZKbG0X6KA4iA5BEsZHwhbTUSl+4phIALbJ8MFwkUdhfWTLRa1WBtZKIpp2cPteWd+L1ez0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Gn7aVa82; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Gn7aVa82"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e6391b114so248538485a.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786957120; x=1787561920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlSy70LSgeXYw8KldCBlLySiG6CNtFtCSMsajfCCqqI=;
        b=Gn7aVa823MfmXuMqOogFX2ETiTUfmj9wvsJ4+/rSj9BQ/gIE5W4j+7xkYk+yuYon5+
         49Z/f6CZl0ief1qjJqtduTePg98l6s7Dmbr91g5CuDKnzu7Ytrft4Uav6tBZMX+dgsGA
         H4Lj7YAL2M6YvaiNMSaxLNcndGZeyRpQZig5USaKFhI2C5d/LCM3jPk4ckcwzv6gaHz8
         fnl80ve7btnqVwBdCSPt7txqnUcJEjfr+ZIkOF6pRLsnj+SKK6IFwVPqPbxMv7gV9mM1
         XZN+l0UR8gMBDtutbJcZ+G5YYgxg9k90MZo5tG3wO+P1xGSvjyoXP2C1LcPwFvp6sou8
         Gh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957120; x=1787561920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlSy70LSgeXYw8KldCBlLySiG6CNtFtCSMsajfCCqqI=;
        b=g3/FoEHffbK45t77pTScZGDd6B0iR+XUNLP/1xbITo4UXe/9Q4y4DWrpsgOc1nAqfV
         Fk35xK5+IH6ABO3tYmCd9b8uTgQky69VQ5WAQ+MLbGyaQcKESt9cu/IbCaOPG0KkjAQY
         d0ULnj2xOgPntYMYkP4zw7xLcbsZz8BZoym72K9UO9PbWgYGWXPz/oAlFMqPQ73PafS8
         06AXWdhEDKvYlkiDVlhaBUW06vgD3SSi0rSw7nr8sZGv0dCRsBSwA7Hl7DAcIDDJzeBM
         C8Iu2a+aBC8N1hkuQ+gQ/4pyYqWDrn7ftsd/7luTUqgGq8h3oT53gH3RuetiVjc+3AX4
         JHag==
X-Forwarded-Encrypted: i=1; AHgh+RpAOAFzDaMh1qGUZwLgHviLLxzna5H8c8mgWTzjFCCsosrrCUUznsYHZtxAp7sTQK8pf+/l7JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXI9m8TuNQRZAYxkAh7ouRUNRbOty1DcYBZUygIIbz1pKxMOX3
	w/56AlmenEMc2Jmm7moXvirUOPlLsaoFR5QkNHBo3U5HtBTRWxpbpVxz3D+qRCgdJ2E=
X-Gm-Gg: AR+sD10AVdqsy95Aig5QN1SMgXJhvwIGBTa14R77na8sICkOa53j7g9YbaQP5blKGgD
	kHeLqPjSLWD4HEMOnFM/6r7bS5ev8xbs8BAZc93NL2XPz1pfxDlfIDmI01+3MdGtB8dbRcpy5d1
	U1ZP9bMXL/99KtovARpYJaVKMQgu7HLGR3UIl9xisHoN786hHpjgp7bmU5/pdCVkSJD4NPegwQI
	8g8ij9AEgVFowzB1lE7KXMbB69gnvxvN2V30aXbclGmxQO3pFXZoQXdw+RCTap34J5JkE3T2/y8
	wrZdu2VhMwN17WK09aO+20jitjM73ehmlSxfzZkQ0NdJ0VZZeeJ2MDsk49N/f0CIpwvwGOby0U2
	D2gOx++XsRa7aNs8U/QU42QATNojmBscSuP5UWaTNLiF5lpSjvSp3Sp/nlMC03fv6ISt6+lhI97
	epd+njvjax0SIZPcQls4FwLYgVUzS13msaEf5ZIhq+tP+UlnRTsQIbD68xiMOW3Y2ocQ==
X-Received: by 2002:a05:620a:404a:b0:936:e18d:763d with SMTP id af79cd13be357-936e18d768amr1778024185a.8.1786957120406;
        Mon, 17 Aug 2026 01:58:40 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-936ce24564asm946812285a.40.2026.08.17.01.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 01:58:40 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	horms@kernel.org,
	stefano.salsano@uniroma2.it,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v4] ipv6: seg6: clear IPv4 control block on IPIP decapsulation
Date: Mon, 17 Aug 2026 08:58:38 +0000
Message-ID: <20260817085839.946321-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

End.DX4 and End.DT4 decapsulate an IPv4 packet through
decap_and_validate() and send it directly to IPv4 routing. The inner
packet therefore bypasses ip_rcv_core(), which normally clears IPCB
before IPv4 interprets skb->cb.

The skb instead retains IP6CB data from the outer packet. IP6CB and
IPCB use the same skb->cb storage, so IP6CB(skb)->lastopt overlaps
IPCB(skb)->opt.optlen and srr, while IP6CB(skb)->nhoff overlaps rr and
ts.

The sender can make the stale optlen byte nonzero with a valid outer
extension-header chain. The reproducers put an eight-byte Destination
Options header immediately after the 40-byte IPv6 header and before the
Segment Routing Header. ipv6_destopt_rcv() records the sender-controlled
Destination Options offset in both lastopt and nhoff, setting them to
40. On the reproduced little-endian x86-64 kernel, IPv4 therefore sees
optlen = 40 and rr = 40.

Both tcp_v4_save_options() and __ip_options_echo() skip option copying
when optlen is zero. Here optlen is 40, so the TCP SYN path allocates
room for 40 bytes of option data and calls __ip_options_echo(). The
stale rr value makes that function read inner packet byte 41 as the
Record Route option length. The reproducers set that sender-controlled
byte to 255, so __ip_options_echo() copies 255 bytes into the 40-byte
option-data area.

Separate End.DX4 and End.DT4 reproducers on the unpatched v7.2-rc5
kernel both produced:

  BUG: KASAN: slab-out-of-bounds in __ip_options_echo()
  Write of size 255

The relevant End.DX4 call path is:

  __ip_options_echo
  tcp_v4_route_req
  tcp_conn_request
  tcp_v4_conn_request
  tcp_rcv_state_process
  tcp_v4_do_rcv
  tcp_v4_rcv
  ip_protocol_deliver_rcu
  ip_local_deliver_finish
  ip_local_deliver
  input_action_end_dx4_finish
  input_action_end_dx4

The relevant End.DT4 call path is:

  __ip_options_echo
  tcp_v4_route_req
  tcp_conn_request
  tcp_v4_conn_request
  tcp_rcv_state_process
  tcp_v4_do_rcv
  tcp_v4_rcv
  ip_protocol_deliver_rcu
  ip_local_deliver_finish
  ip_local_deliver
  input_action_end_dt4

tcp_v4_save_options() is inlined into the tcp_v4_route_req() path, so
it does not appear as a separate frame.

When decap_and_validate() handles IPPROTO_IPIP, save the ingress
interface from IP6CB, clear IPCB, and restore the saved value. Doing
this in the common decapsulation path covers End.DX4, End.DT4, and
End.DT46's IPv4 arm.

Use IP6CB(skb)->iif rather than skb->skb_iif. These actions run after
l3mdev processing, which can replace skb_iif with the L3 master;
IP6CB iif still records the receiving interface set at IPv6 ingress.

Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
Cc: stable@vger.kernel.org
Suggested-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v4:
- Explain how the stale occurs.
- Include the observed End.DX4 and End.DT4 call paths.

v3: https://lore.kernel.org/netdev/20260810154732.850472-1-david.lee@trailofbits.com/

Changes in v3:
- Clear IPCB in the common IPPROTO_IPIP decapsulation path so End.DX4,
  End.DT4, and End.DT46's IPv4 arm are covered.
- Preserve the ingress interface from IP6CB instead of skb->skb_iif,
  which can identify the VRF master after l3mdev processing.
- Update the Fixes tag to the commit that introduced End.DX4.
- Include the End.DX4 and End.DT4 KASAN evidence.

v2: https://lore.kernel.org/netdev/20260804094625.715305-1-david.lee@trailofbits.com/
v1: https://lore.kernel.org/all/20260731140832.567669-1-david.lee@trailofbits.com/

 net/ipv6/seg6_local.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0dddd..95ea0b62729a 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -256,6 +256,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 	if (iptunnel_pull_offloads(skb))
 		return false;
 
+	if (proto == IPPROTO_IPIP) {
+		int iif = IP6CB(skb)->iif;
+
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = iif;
+	}
+
 	return true;
 }
 
-- 
2.53.0
