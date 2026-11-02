Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793583937;
	b=tvgXFD8lH6yeqlVDoGObuZLXI55b1Jxp7upYeOwLsl3zc5sHffue0XV/ZYUtgXTTDbgU
	 /Uay7R08QhrnBwbvDmXct+2675ItrgScLDUc+0zbZJPdK+zcwEGQ5PRbLqG26DqbHfMgW
	 FFapDzgqoAebC4BhgDOGanWS6FsBtDPfvPX2YxQ4uI6nEoAdLsEv52ETvfKtqtf28XdB8
	 0GYOMuVbdGkTQ8jqolaDF+n2953Ki13et/aoNiNIbwxvDGm1IbDUtqCHTXL9RJnFgsvwf
	 ZVs7Eu9mn8X/pgWQOxK0iBfgdrugNMZW3+VswjHvpLvbanEnHSUTg+nrp20/7vdohcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583937;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Eeswh71nQ4eodvDnqz28Zx2VhRFam1DEmTWBcVLFmgE=;
	b=ZkGAXMyNQ1E4ZLRNIhsZtfOXm9NT8hN7yQ0kmYcCb6huqnrCDaEl482Js0DCMLGkqvDl
	 xz+88eblrv760/6dZK4+sxOmQ8L+78Jwn7ey20IOR7G0EblhbvV2c6VTzggPHOP5m80pw
	 dw56iolvkx5SoNsjeXW1U66HoU4nfA3vCqOUPBHBOiBF7loT0KKnZW5QT9KU1Fa+gs4S5
	 HrJh2TltHEkSnwMboFKItSiWyrYujO/1Qq20Oh5ELYNb2lc5ZxpVo+PvaMig1QUKpKGj9
	 uEpdawDwuKexLJp+Gv29rZdgtDAHmdQcFNK97XSXwNAHDdiBTscJUoPKjo1O5K8hRbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2C6I0nJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD22606A324;
	Mon,  2 Nov 2026 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2C6I0nJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793583936;
	b=Y2WQBc7XCWNj72+1J0hrDEKkS+xv5xWz2AuCl1HGE96onZfcL0g5j2F4eZB+jp0wnEnK
	 qS7sXM+cin/C2RyBzlbyXdOJSmt6wkTxxq8gH+MFQ0LA642lpZvSCrFcbqhqalOjm6+f6
	 OznYMUk1ZAkEYbxCqGsaatt93HjbTLt1Dt/zZpR26drPJlnOhPtCo7b6ZiKWU690Akr7i
	 ip1H1e89Tr8n6MwlZjl1ux2r731dtu2yCOMxW3flG6QglL7kVLnXb9X+stsiprJFUpQW0
	 mWo7hIDo7IkFWv+qg5DM9iSgKWQ18S09y9xnS5Hc/z/fkMKXNOWR2RoDWj8Y6BQ1UtQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793583936;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=Eeswh71nQ4eodvDnqz28Zx2VhRFam1DEmTWBcVLFmgE=;
	b=npieCHKqPPRmhbwXj02u77QK8pKhS1AKr0E0Ek/o0H/OdrKkh5VHOEnXVGTmbQHCOUMS
	 4nhq6OM2GDwB1yBeLlFNeVVNItM6zH1gPz13YGt3/NxE96oV+VMgDRpdaA6RF95PFMXgh
	 9igy6Y/6anNKpnA/s14+yHvDWGvhn39lEswjkWZmoefJdfiePvgl/pXXkA9fhA+uZZmjI
	 rRbVe1zaTjSoqBy10Or2XoTtyClCYZ10+6CkQjco/T4otZp0xEsqBPal3ULMhiUsI3JBk
	 Ysz/uU9vR/2DmqtFBmZUgdPPmJPdnX4QxDSMa9N9y71AZfiiAmU80pccFfcUDRtEklQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B6E9F1F000C1;
	Mon,  2 Nov 2026 01:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793583936;
	bh=Eeswh71nQ4eodvDnqz28Zx2VhRFam1DEmTWBcVLFmgE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=a2C6I0nJElHZfJN2J3Jv9VEc40zyffVSAj9ZIz+3t3zxdoSTHdvUSs5vAvpKjbPBz
	 iw2bSc4vaan2GS1d4vxqrvCqapNtfrDVqAN+ibxQaF/wHeTlDMJrXxgu7jJ+OXkVb/
	 HEjQMGDslzIIbSyUgpPxq4C4bkE/JxOGRDOgiGYXRG5eZdMXFFOKrwuelR3c8Pg7Qe
	 88ZwVFoDmPA8XE6IMI39C921jTegv31Pb87zqR5OseY5nEZvEvVVF7IMy3HXE2p1KQ
	 UCQESVyypNt0orDSDoX5OZ1HwmxmR/kNBT+4tzqYFQe0v3LGUEYeQnJzawm4wYbGWj
	 accUjoZtVArFQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3508346302;
	Mon,  2 Nov 2026 01:45:35 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 01:45:35 +0000
Subject: [PATCH net v2] openvswitch: advance by the real header length in
 get_ipv6_ext_hdrs()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-ovs-exthdrs-v2-1-21ceef6a243d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD7r52oC/x3MQQqAIBBA0avIrBN0IImuEi1Kx5yNhRMShHdPW
 r7F/y8IFSaBWb1QqLLwmTtwUODTlg/SHLoBDTprDeqziqbnTqGI9tbYOIVxd+ihF1ehyM9/WyD
 TDWtrHwUwQcRiAAAA
To: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793583934; l=4412;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=hupOxG9gfTdg83Q56zynhHUJuMArSkJdz7lPZA5eIFw=;
 b=sjAGEwAfDl/oGKwvKIn9mFWS2sHBz4fC5dT+I4IDVYbp1Yt2G4YHThpjVkGolAxISJOHufuvn
 duFFwC6ZeezCQGyhQBOMBK4RxBdWNgdJeREkS4zgx7jrsuR3p59Jf+M
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

get_ipv6_ext_hdrs() walks the IPv6 extension header chain to fill
key->ipv6.exthdrs, but advances to the next header with ipv6_optlen()
whatever the current header is.  That is only right for Hop-by-Hop,
Destination Options and Routing headers:

 - an Authentication Header is ((hdrlen + 2) << 2) bytes long
   (ipv6_authlen()), so with hdrlen = 4 the walk skips 40 bytes instead
   of 24 and reads the next "header" from the ICV and payload;

 - a Fragment header is always 8 bytes, and the byte read as hdrlen is
   its Reserved field, which the sender controls and receivers ignore,
   so a non-zero value makes the walk skip up to 2048 bytes and miss
   the headers that follow;

 - in a non-first fragment nothing after the Fragment header is a
   header at all, it is the middle of the fragmentable part, yet the
   walk keeps parsing it as an extension header chain.

In all cases the OFPIEH12_* bits stored in key->ipv6.exthdrs depend on
bytes chosen by the sender rather than on the headers that are actually
present: payload bytes that look like another AH or a Hop-by-Hop header
add OFPIEH12_UNREP/OFPIEH12_UNSEQ, and real headers after a Fragment
header can go unreported.  Flows that match on OVS_KEY_ATTR_IPV6_EXTHDRS
then classify such packets wrongly.  There is no memory safety issue,
skb_header_pointer() bounds every read.

Advance by sizeof(struct frag_hdr) for Fragment headers and by
ipv6_authlen() for AH, and stop at the Fragment header if its offset is
non-zero, as ipv6_find_hdr() does.

Fixes: 28a3f0601727 ("net: openvswitch: IPv6: Add IPv6 extension header support")
Link: https://lore.kernel.org/all/178905555085.219967.6617611783437228045@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
Changes in v2:
- Stop the walk at a non-first fragment, nothing after its Fragment
  header is a header (Ilya).
- Drop the Assisted-by tag (Ilya).

Found while going through the pre-existing issues the Sashiko review of
"openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()" pointed out
(Link above).

Tested by building get_ipv6_ext_hdrs() from net/openvswitch/flow.c
before and after this patch in a userspace harness (skb_header_pointer()
replaced by a bounds-checked memcpy from a buffer) and feeding it
crafted packets:

  AH(hdrlen=4) + DSTOPTS + TCP, payload mimicking AH at old offset
    before: AUTH DEST UNREP UNSEQ      after: AUTH DEST UNSEQ
  FRAG(first, Reserved=0xff) + DSTOPTS + ROUTING + TCP
    before: DEST FRAG UNSEQ            after: DEST FRAG ROUTER UNSEQ
  FRAG(offset=1000), payload bytes looking like HOP + DSTOPTS
    before: DEST FRAG UNSEQ            after: FRAG
  ROUTING + FRAG(offset=16), payload bytes looking like AH
    before: AUTH FRAG ROUTER UNREP UNSEQ   after: FRAG ROUTER
  FRAG(first) + ROUTING + TCP, HOP + DST + ROUTING + TCP
    unchanged

net/openvswitch/ builds cleanly with W=1.  I did not test it on a live
datapath.

The analysis and testing were done with help from an LLM-based
assistant; I reviewed the change and ran the tests myself.

v1: https://lore.kernel.org/all/179328922134.76862.10417963652853801970@gmail.com/
---
 net/openvswitch/flow.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 1c4f3a079..3734416b5 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -369,11 +369,28 @@ static void get_ipv6_ext_hdrs(struct sk_buff *skb, struct ipv6hdr *nh,
 			return;
 		}
 
+		if (next_type == IPPROTO_FRAGMENT) {
+			struct frag_hdr _fh, *fh;
+
+			fh = skb_header_pointer(skb, start, sizeof(_fh), &_fh);
+			if (!fh)
+				break;
+			/* Only the first fragment has the headers that follow. */
+			if (fh->frag_off & htons(IP6_OFFSET))
+				break;
+			start += sizeof(_fh);
+			next_type = fh->nexthdr;
+			continue;
+		}
+
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			break;
+		if (next_type == IPPROTO_AH)
+			start += ipv6_authlen(hp);
+		else
+			start += ipv6_optlen(hp);
 		next_type = hp->nexthdr;
-		start += ipv6_optlen(hp);
 	}
 }
 

---
base-commit: 94cea342e8915812b45f93c56e134041c7fdb4d7
change-id: 20261102-ovs-exthdrs-c101f8d5b62c

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


