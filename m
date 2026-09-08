Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7E538D8C;
	Tue,  8 Sep 2026 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870529; cv=none; b=TxtoBMBEa2RmiAn67s0UeQTCEYqTWIRjXPew+xwSrYp2lzi5YE2Fle6FIcEuYZcYujMPqTO2pg/75hR7uS4/PVO97RLYQi1EBoloG/aGDkkBpw+4bpmyLPkSoGlbrMWqnJy8og5ZPn7ot2U8B3RPU0JWmsYbjSmXIHNjwqRBq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870529; c=relaxed/simple;
	bh=P2CRJ07STOVeF5+bDERqP47YhqQVSacGqvmYwwhWPls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZHe2oPXxvR1AS7X36iFfNvF4mqDYb7ThuEWKYlO1OZ8nYASAuB+iAiD1dQ8tbyEClrizfFQSN7yGU1r8hCdU6AZcbyR6JNx7Ff+f05KthszJc7gpwYbR6BhraOm4XkFTaRgQi7IeyJhFjbD38zxpHCT0+kmx2pPLrzEAk58wUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ybAgKRyL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8JyfE/b; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ybAgKRyL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8JyfE/b"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4CC65EC0101;
	Tue,  8 Sep 2026 08:28:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 08 Sep 2026 08:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1788870525; x=1788956925; bh=RxpfrAjvYh
	J5kwVO2DlgQtG4zZ+hz8Fnr8PN+y4mezk=; b=ybAgKRyLTG1ec0ViZ94kAsv3cx
	NUobWUCnsl7kHW09y0Ny4gpMTV8G/jJBhFWRlPHy3AtxefL52VOuOtEeV7qZGlO2
	3/3qzvSweGuFIA3iWnta7XEJmgD716V46axw+yK1gRuaA9MNyTPB3VWkEpC59kBq
	0T0DVD6ZoshOWJoR8yugJ4wfBAgLdtLgrS/yP5pfjBgrHCp/7LMpYFbD8oPSK+dy
	8gQVAhOH7EWRnITLdsiK7caWOkaSPrZNsozOJoSfY6Patejeg+Kq5Dj5JMJaIW1m
	7ImiQn8YV0off2XeGHOcLQJ3KzzcSCstz8igzeL8A6cON+0As0H9jddyLJYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788870525; x=1788956925; bh=RxpfrAjvYhJ5kwVO2DlgQtG4zZ+hz8Fnr8P
	N+y4mezk=; b=S8JyfE/bujFZ7+WlmbOZPwFyg6NpCCZcxnMLW//MAHS0T2dENqn
	n+mTpYnAUvVPprCbrpi7vEa1qKpVyFSWz6ldnBS5LLO8C1gFczA/kP360wBpLUjt
	2fnvbljEpo7kxawjzs5kzu0OT5/9OtpEU+dKMZa1o8ocVUbEw/OPIXYF+uOWScAc
	H4RxT9wzI8xRn1eDQtPK/su4x0u+cfWmg3SyBEv+ARzKV6oWwyktoNxnWghoY4oh
	3g5jA+/jTT2OSijrgHWj1qfR18JN6LBUsluKNgKDBdT/687z5Apjk9asTCCCabJf
	xKOd2CPcpuBobCrlL3ddLR7gBgEK4QkH2jg==
X-ME-Sender: <xms:fP-faqQO2JIjOslzG-YHtIOt8YHwrGqy5Yp5ATeoh4o6nJ1k0kTrJQ>
    <xme:fP-faqqdKMg5vKi3fXED4FesscB6rUbLt32EJBQ8SGV6c2UX44cIDrfHjRkfjLai1
    CCQGFHzY2cBWb42MzRZovscbnYC6pdVexzW8Gfu1B8_M1G42LdTg3I>
X-ME-Received: <xmr:fP-favqd2N45y_IDwDFPLY_i0g8Hze0zcB3ojop6BUqkkTl2WEo7_5KC4doHChEPM313wGgkQ0Dcf4MkZJhZyPFdy0QDfzE6T4QnlaAUr7zd5A>
X-ME-Proxy-Cause: dmFkZTFzi9YT2CZmIgY/5HleznU3GF/eBNJlQaV2F/qwPHY6XzEmG3v1bGMK4BrCwwbdvt
    OmktFnrUmHUtBxeq5xoI3x96h3dEq7DKOcs2zyvcuNhlAcbV30PSHYRKGlz9VwyvUNghXI
    nG4nCHjgNJjiIZbSci5jjqUVqf1THSH6xKEQFKsia3ccY7qupWmA0fvwBrIDidENvh9R60
    QdhepxbLXkmVrUqIYvPiexvnuue+y1/P19HPkwvjQseF3DApxsh0Yt1bd+2EpJTDP6uO2q
    JbF5FW1XyIiFZUyjuequkhHj7inWWVq5cxQ2a987OQhL9MJPmwvpp7iYZ1que27vmGHpaC
    ZKNFdSV8nHimVO2WQJkqr5lG1WjK4we2lprXTEVUE5gnROMAWiNGqqe9ZK4G5yZbgrE3Gw
    GtiLSieLLwwOuvqgIQlvBwwcLr8Ou9AEZ9MOGWxnitF5O4pYZL7csXUDOEHmdZXtCHxwgn
    C/MA3LYKee1B28wF4AaxYn77dwKKTs8/nXtxmuIy9oWPeyzgafDcjL43LIY9KR8pgbudt8
    0ATE/cLsqJtc5dNe4byKY6aJGTgPEk3q+6plnZROgYsecokbcW3YgnNojqY41Z0++Zexy/
    yC48THX2U3eML+TYpsU+fMNfcYlq73UZ+/438uU/PVjUl/hwvzotzB6QfSiQ
X-ME-Proxy: <xmx:fP-fakPti1yVIJYAfdIedTVbo5FadWq-E9b_mgtSZYgnDwSU01Iuhw>
    <xmx:fP-faoxFossMjLiuEPx9Uiqri136cJumLivK4IWKDIhPRJtaaBKk1Q>
    <xmx:fP-falua5LCTlam9c4ZVNkECEv8XIdtoq8bLUduSkPkPCpaIEsIy1g>
    <xmx:fP-fap7IfThbh6FsRGnbjk9mmotfsUQUHMz3cjJvFiDXsGdUO43l4w>
    <xmx:ff-fah7kT2asBGz8UgQt4x-sCCNY57uO36uuK0FzRXa7uISp5bSuM-S6>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 08:28:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] firewire: core: fix source bus ID detection for AT context in big-endian systems
Date: Tue,  8 Sep 2026 21:28:40 +0900
Message-ID: <20260908122840.2886621-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The source bus ID bit in AT DMA context is not detected correctly on
big-endian systems because the little-endian data is not converted to
CPU endianness.

Fix the bug. The helper functions related to this are never used in
driver code, so extend the test to check the field instead.

Cc: stable@vger.kernel.org # v6.12
Fixes: 8db9d1557122 ("firewire: ohci: add static inline functions to serialize/deserialize data of AT DMA")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci-serdes-test.c | 4 ++--
 drivers/firewire/ohci.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firewire/ohci-serdes-test.c b/drivers/firewire/ohci-serdes-test.c
index 258f668619ef..87b136e041de 100644
--- a/drivers/firewire/ohci-serdes-test.c
+++ b/drivers/firewire/ohci-serdes-test.c
@@ -43,7 +43,7 @@ static void test_self_id_receive_buffer_deserialization(struct kunit *test)
 static void test_at_data_serdes(struct kunit *test)
 {
 	static const __le32 expected[] = {
-		cpu_to_le32(0x00020e80),
+		cpu_to_le32(0x00820e80),
 		cpu_to_le32(0xffc2ffff),
 		cpu_to_le32(0xe0000000),
 	};
@@ -56,7 +56,7 @@ static void test_at_data_serdes(struct kunit *test)
 	unsigned int destination_id = ohci1394_at_data_get_destination_id(expected);
 	u64 destination_offset = ohci1394_at_data_get_destination_offset(expected);
 
-	KUNIT_EXPECT_FALSE(test, has_src_bus_id);
+	KUNIT_EXPECT_TRUE(test, has_src_bus_id);
 	KUNIT_EXPECT_EQ(test, 0x02, speed);
 	KUNIT_EXPECT_EQ(test, 0x03, tlabel);
 	KUNIT_EXPECT_EQ(test, 0x02, retry);
diff --git a/drivers/firewire/ohci.h b/drivers/firewire/ohci.h
index 218666cfe14a..63ccf2f44504 100644
--- a/drivers/firewire/ohci.h
+++ b/drivers/firewire/ohci.h
@@ -178,7 +178,7 @@
 
 static inline bool ohci1394_at_data_get_src_bus_id(const __le32 *data)
 {
-	return !!((data[0] & OHCI1394_AT_DATA_Q0_srcBusID_MASK) >> OHCI1394_AT_DATA_Q0_srcBusID_SHIFT);
+	return !!((le32_to_cpu(data[0]) & OHCI1394_AT_DATA_Q0_srcBusID_MASK) >> OHCI1394_AT_DATA_Q0_srcBusID_SHIFT);
 }
 
 static inline void ohci1394_at_data_set_src_bus_id(__le32 *data, bool src_bus_id)
-- 
2.53.0

