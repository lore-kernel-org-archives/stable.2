Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901526;
	b=x5buq0rECC5texzflGAsRkOdTCELiU/lfcxOzvFzPqeDMBaOQOmSxnSTKiwauNU1gYvv
	 6nPJ48JIQeSPX0py6TdbUmjEZXftxV17ceML8CgqCg0WHL8CS5o7HoJbI3i+PGJWsufzW
	 xkEbaGc10p5a9xCnY/IMqS3C/3Qww7YuzuEF2C7ICt+KGUvQMqZDeu5XIEmmclGRyUsXV
	 bui8I2rC5jci4kV68taV1LqKfv/HgBrAdTBub64kOxgszR2vDom9k7Vnyw1i1RCNYvaqR
	 cI3xxpUxMrzCOrOBgIgXwN6UKsTPqZovTvemcQpstmSWc5GSEzCogBqWET7dp04EZbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QMWNLA8a57Rf8OO7YlswvRzJyJ3mRqdnDnkZaotiQPk=;
	b=cQDEl1LiSLwreuPlFfgsSyDOXwegtm6H+seZ6aAC6QwWoDOvogmmdedpxktOPzyUV8E8
	 P1idyQ4qy0lRI5eiant63kqtIA17OUOcPu+vPIIbMq6Ofr5UfzfoZ05eKLSzCs82dw5Wr
	 tLl8mYY+LS6IdgOqf1UhCaoLRjdUOrGoL+LefeQgUAEREWybDJsR8MO9zlYQnPnI+KkuD
	 myv+AYgO/MIh/zUe63IDZq0YSTN1MplKQcMK0r5Y0itLhyxoiujp3qQRrZWYE6dKVZrGK
	 3ljfN6xLxnSsbPPXH10q5OxQqCTc4gMFc0RXMPnVyPNy31n5FkbghSszpYIXrkyNKag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdVwKzmK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F9606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdVwKzmK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097601F000C1;
	Thu,  5 Nov 2026 17:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901525;
	bh=QMWNLA8a57Rf8OO7YlswvRzJyJ3mRqdnDnkZaotiQPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HdVwKzmKbhpbtIlrky3n4zkXpBgv+g1uYSRNRfG8HLLxAV3+Qu42kn4NpmfQvudGl
	 wf6bWa48GEtVNytMyZDRHiiwrPqZrJLNA0XpCtHcFTF4M/Op/HUR43aucg43g22FNY
	 scwSHkXrsEZ3pMDl0J8MVIiOed/A0xd4NY4FWGeyt769M0K/pHtWnJyQs5B+HI15ue
	 nlmFX0RPFCm1mif/yp5lPuYrFPDpba618+oR9x9GXqMkMRVgujB2wrDep/9pWcNghs
	 Ub+0UWTPFhwFBfSRbJExyW/k+WvYbW36BYY6smoyL6RVL3qor4gB6pfcNVGR1ulXDu
	 jUMzhsNVivfKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/8] smb: move smb_sockaddr_in and smb_sockaddr_in6 to common/smb2pdu.h
Date: Thu,  5 Nov 2026 12:58:36 -0500
Message-ID: <20261105175828.2192358-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110435-maternity-atlantic-ccce@gregkh>
References: <2026110435-maternity-atlantic-ccce@gregkh>
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

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit 7844d50ca239f0788e732608820f7026cb0cc8fb ]

Rename 4 places:

  - iface_info_ipv4 -> smb_sockaddr_in
  - iface_info_ipv6 -> smb_sockaddr_in6
  - IPv4address -> IPv4Address
  - IPv6address -> IPv6Address

Then move duplicate definitions to common header file.

Co-developed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f8171804a39e ("smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c |  8 ++++----
 fs/smb/client/smb2pdu.h | 13 -------------
 fs/smb/common/smb2pdu.h | 15 +++++++++++++++
 fs/smb/server/smb2pdu.c |  4 ++--
 fs/smb/server/smb2pdu.h | 13 -------------
 5 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7cf6419df037d..71cf42981ab04 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -635,8 +635,8 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	struct network_interface_info_ioctl_rsp *p;
 	struct sockaddr_in *addr4;
 	struct sockaddr_in6 *addr6;
-	struct iface_info_ipv4 *p4;
-	struct iface_info_ipv6 *p6;
+	struct smb_sockaddr_in *p4;
+	struct smb_sockaddr_in6 *p6;
 	struct cifs_server_iface *info = NULL, *iface = NULL, *niface = NULL;
 	struct cifs_server_iface tmp_iface;
 	__be16 port;
@@ -698,7 +698,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 		 */
 		case INTERNETWORK:
 			addr4 = (struct sockaddr_in *)&tmp_iface.sockaddr;
-			p4 = (struct iface_info_ipv4 *)p->Buffer;
+			p4 = (struct smb_sockaddr_in *)p->Buffer;
 			addr4->sin_family = AF_INET;
 			memcpy(&addr4->sin_addr, &p4->IPv4Address, 4);
 
@@ -710,7 +710,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			break;
 		case INTERNETWORKV6:
 			addr6 =	(struct sockaddr_in6 *)&tmp_iface.sockaddr;
-			p6 = (struct iface_info_ipv6 *)p->Buffer;
+			p6 = (struct smb_sockaddr_in6 *)p->Buffer;
 			addr6->sin6_family = AF_INET6;
 			memcpy(&addr6->sin6_addr, &p6->IPv6Address, 16);
 
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index cdf7c588cc00d..de2d83c6463c9 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -255,19 +255,6 @@ struct network_interface_info_ioctl_rsp {
 	__u8 Buffer[126];
 } __packed;
 
-struct iface_info_ipv4 {
-	__be16 Port;
-	__be32 IPv4Address;
-	__be64 Reserved;
-} __packed;
-
-struct iface_info_ipv6 {
-	__be16 Port;
-	__be32 FlowInfo;
-	__u8   IPv6Address[16];
-	__be32 ScopeId;
-} __packed;
-
 #define NO_FILE_ID 0xFFFFFFFFFFFFFFFFULL /* general ioctls to srv not to file */
 
 struct compress_ioctl {
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 528ba77247e80..1bd5835c56e45 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1433,6 +1433,21 @@ struct smb2_ioctl_rsp {
 	__u8   Buffer[];
 } __packed;
 
+/* See MS-SMB2 2.2.32.5.1.1 */
+struct smb_sockaddr_in {
+	__be16 Port;
+	__be32 IPv4Address;
+	__u8   Reserved[8];
+} __packed;
+
+/* See MS-SMB2 2.2.32.5.1.2 */
+struct smb_sockaddr_in6 {
+	__be16 Port;
+	__be32 FlowInfo;
+	__u8   IPv6Address[16];
+	__be32 ScopeId;
+} __packed;
+
 /* this goes in the ioctl buffer when doing FSCTL_SET_ZERO_DATA */
 struct file_zero_data_information {
 	__le64	FileOffset;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a8a42fde4ca02..55d634b5d2e2f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8297,7 +8297,7 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 			idev = __in_dev_get_rtnl(netdev);
 			if (!idev)
 				continue;
-			sockaddr_storage->addr4.IPv4address =
+			sockaddr_storage->addr4.IPv4Address =
 						idev_ipv4_address(idev);
 			nbytes += sizeof(struct network_interface_info_ioctl_rsp);
 			ipv4_set = true;
@@ -8305,7 +8305,7 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		} else {
 			struct inet6_dev *idev6;
 			struct inet6_ifaddr *ifa;
-			__u8 *ipv6_addr = sockaddr_storage->addr6.IPv6address;
+			__u8 *ipv6_addr = sockaddr_storage->addr6.IPv6Address;
 
 			sockaddr_storage->Family = cpu_to_le16(INTERNETWORKV6);
 			sockaddr_storage->addr6.Port = 0;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 23abb70ea5d3d..48026edb7314b 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -138,19 +138,6 @@ struct create_posix_rsp {
 
 #define SMB2_0_IOCTL_IS_FSCTL 0x00000001
 
-struct smb_sockaddr_in {
-	__be16 Port;
-	__be32 IPv4address;
-	__u8 Reserved[8];
-} __packed;
-
-struct smb_sockaddr_in6 {
-	__be16 Port;
-	__be32 FlowInfo;
-	__u8 IPv6address[16];
-	__be32 ScopeId;
-} __packed;
-
 #define INTERNETWORK	0x0002
 #define INTERNETWORKV6	0x0017
 
-- 
2.53.0

