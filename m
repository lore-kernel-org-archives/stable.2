Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589614;
	b=o6Uqs5Yp8EBrZCFGjio8ft6WLh9t4Uc1RO+VqRVcBenY8Ukyt6hBbp04FJRgrJ2BJaCB
	 tTxf5TIFmOLhRBLuJkiHmIFlqrpkjM7THKsGJbe4Bf0as/qLNu/zVxiX147UCjK8LPvAV
	 MFkfKWDj5S7waNSnYLZTkecPwYcEd7fysth3PkjulaxrxqqH6/zGze01F3xDviPwD4Ofe
	 CHjFS7/x6wlQMpzYR+PQIiukZx8CLiEazVUZP3Q/YWdaNnMll2hAE1KaTMyUlndoE93/A
	 jRRQDbBkJnBPhE6DTP/i2AJQxif+y+EiYY5alcAgqKqUUaEDVoGaINkFJOd4TOoWAgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589614;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
	b=Of3klyvaDX3kbWvmenuxIWiAhLWCK5NVrv4NkG1X7NyRHOU+8g1rDm2BVYlF+bpHh7k9
	 9HdLpBRc6nF4E/09x2FZgJY27GnTVsoPAT/RKnbJ9/nE9PfGuTzxySKMGXeZjatsZSmFg
	 BVlEKTD/Hdh7uEU9s90uaAmYiodfrpFGAFabx3QPYngI2BRzuQMz+Rvfh3E1CxbnB+sl2
	 LvMDFW6GdvTiz+1W15Qz/LURu5+YTzhDvm6qwpCiqmcCQcNdZW3cnHsjjo6DkOOePu6oo
	 Cyi+/OODctU0an2KFXR6Y8KZUcRlsEuTCvmDrfCeHkKnKgNMdWPDbB9JvyYZuhLVoAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTwIU9jp;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DN0A8kzP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307B606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1307B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTwIU9jp;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DN0A8kzP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794589612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
	b=YTwIU9jp1H10/trgxoH529RJD//rDcGtE/KAHUwAzqP+nffumFcQFMYAHwZ0FDQQXW10US
	n6Ddv5SnAAQhK87ICTIY3r7JinhINqywi3mk2UwUdm+LYDmJSHFeOiuWSrhYMSUhvYOYEI
	DQE18t5VK5D9lcaFhulAmIpiIhXdNJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-_rB3PU52NXaC1p5PpTx3HQ-1; Fri, 13 Nov 2026 12:06:50 -0500
X-MC-Unique: _rB3PU52NXaC1p5PpTx3HQ-1
X-Mimecast-MFC-AGG-ID: _rB3PU52NXaC1p5PpTx3HQ_1794589609
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ae2756fa7aso6759365e9.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794589609; x=1795194409; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
        b=DN0A8kzP7RKo5fQGq5KIDkrbwb79NY3IE65mhKRVjpzPSTFMS9eMdYv6wgN7jB03k8
         S5OFWCcwkMw5tCtB16JOMgqvqLtXGNFC2gmc8g41p0IXmkraV2y7AcK3Q39pBERBptw6
         IWS40Bc1CIAH64kHFFyf+RGmHxuIJ0fhyAxUWfHmKevHbVfSUm4F6PNY8oAnX3S42pyp
         SUyXtLrVzeJSsN3MLTG9GmVNGNR3xgl2nw0Gm3n8mbAgJZVZapgbaQfXKj2fb2ZIkM3i
         J6/228HRBxCKwci4uHO4D2EJeBiJnknWP//bRZo/7Q623qGSFAYF1puHjnZTsRalv9ym
         ZErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589609; x=1795194409;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
        b=xxVwF3z5RyCCZtucJTrpfbximQFRQjajcOg2atMvdR7u7vk2qVpv+cqPeywpw1yTgy
         GImPXHtW32gd0rYj1ZWk4mOPHCTjX6bpNglvF4BCUJbDhMO6gWtYONV3/lEOLYooRyrp
         v79TvkowRTKiNcuJRvjFECJwYHalvqK+cFunugMHRNKCiMHTbaWC0e9s29sV+DPLW7eZ
         SqzReK9rnaZe8Su5F0/qX2t7YLonAi/lTIKkss1raN7FGNMaloUcjsb6o0FRRYzfXbV3
         1AzZVmPJrgnyMO6ZPx97Ze2S47xMIqo6LhNDXEfp3INqhcOEBvxRy/mDBo31a02W3CGK
         2Rzw==
X-Forwarded-Encrypted: i=1; AL+hErFnjeReqV7ZE7x7kj9awjD1EbaKcEi8qNqbKuBhoGxNVttek+cuB93m/1i9CS0VPubJ8lWJBqc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8K0dASlGfQzIaTZSybDptf4FP2J+BxfkA5+hanR4WhMZb4ZxSR
	KMBYRFmuYlKAPX5/4xpNAVmt9MnRfUhFalSa1rTXNj4FuLGzvmwTp5d3c+G+B72cheBA9/Rn8RW
	v/xwVi0zY1Od7OPBLD7g+DGiumDlMO/paDCYsug979JQbjqbDfFIVr8eG7Q==
X-Gm-Gg: AYBFou2g3xFcV5Vdwv/O84Dl9ZcdFcu4xDgoC7FW4aXNBwjPu3WjXKEMvuTrXJPOn99
	ETny2BRAGDiF0tnkU+GTNq8/q/W1qa+5A97WH3uhKLkeGsT+3BI/55bgyCPyfiDiksa0x7IP0vx
	1k2cifAsaTxxB3nINv2OsnOHJBHEuHsXJLy+PQyk2DgKHhYGR1tFu7/HmBlfpPB6H2ne+FewF7d
	DOxNXd04UFquMsNeQXbVRy5RugMOMKIBAGvhEpS9YDXPJdJXk9J+9wqF9wuBX9fYVDnQ0vNVmmg
	kZREwZjB4aRZLSZ2UDkva5RmLO6wVybPTEhxI44fKd3Ae63HeB9QGQ0k+IyDjDoN4YR/BWG1nSY
	lmxasuacq33ngr7ecD2+L7ygpKhbDtyzyzAj1PwVeEgzPEkQK+WpBei7cNLIZ9Lu//kJW1sEcpD
	FfXgFCmjwUDEc=
X-Received: by 2002:a05:600c:c84:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb55aa3a2dmr71557375e9.31.1794589609269;
        Fri, 13 Nov 2026 09:06:49 -0800 (PST)
X-Received: by 2002:a05:600c:c84:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb55aa3a2dmr71556725e9.31.1794589608889;
        Fri, 13 Nov 2026 09:06:48 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm6409906f8f.23.2026.11.13.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:06:47 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:04:40 +0100
Subject: [PATCH] vsock/vmci: reject datagram binds in local network
 namespaces
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtIjYSuEi1CpxoqDSckiO6et
 HyL/x8QSkwCffVAoszCMRSougK3TmEhZF8MutGdUspglug2zIdjDHQFQZa4T1fJ0FLbWaO989Z
 AGZyJZr7/+TC+7we3RtBCbAAAAA==
X-Change-ID: 20261113-vsock-vmci-netns-isolation-7e46732dcd73
To: Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, stable@vger.kernel.org, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=slp@redhat.com;
 h=from:subject:message-id; bh=KbQnqpP7rtV1X6O9hhQI+C1Zj1a1cacc8D6sCunHM3M=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90Ol4hWRYE7DbdCG5kDAinIgd4TLSotKXr8+l
 VPEwubE0OiJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdDpQAKCRD0aSeNLwwC
 NTBrEACV2PMED4/7MyILMjnxuQfgS6QtiXtgSOjXHHrW3NfewioLlE1yJq6GEI03bNZP+lqKNQR
 AccWn/H2lR3qiABFWlijCpj1bJ6X26crcqVK0PEnG0KLdQkz356ogEpbDZtka1wFJR8w2JDhbRh
 Ys3iF93SvftH8KvSXnk+4rtMnbeUgKgHuL36L9XydhATObsweqMwrKlFJsNMdNpfOAJcpnxaAYg
 OqRFXGGO7Os0d1wmnsJL1uW/b/rMPdDxqWa6DTa1fPo4y4eqlIeWBO7HN7/pkHF7/tyUN+1DH/3
 MQkWZwr+IHTEuF7W29ASzuHcYsauRC2kn9sOFhkT/sEIRAo2exPo7Z9R/WQujO5VG2ZyhvFeWMg
 ymJ2iO2YcbzSPwiuXvjCBEPbht32xQmpRGvFMC/Cc7ZLvKZ0h+62sIROMdWZdi+keTkFZfCLn7O
 hHs6bbahrRf96RF/J30sUH/2kZ5Jkq6gROnToNOk1HJK3bjL/CyMOoTohBR3sR0+uZOaH69RTRl
 8ZSXuy0vIkwZM68jjduCnqtEMeMi8JT2yvpqyV6cq/IXhBqvQ7Jw/1Ik9hioviwwfvY5KyGML9i
 tK5qfhNnseLN7nPGYt4cCJRlBOfE7RajO1maGZq0JO+9wSiQa49D/53RC5VP+bmBLvPGjbT7C05
 ixnW7xHwBAI1d5g==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

VMCI already rejects datagram sends from local network namespaces, but a
datagram bind still creates a receive handle in VMCI's global port space.
A VMCI sender outside the namespace can therefore deliver to the local
socket. Its handle also prevents a global-namespace socket from binding
the same port.

Reject VMCI datagram binds in local namespaces. No namespace-local
datagram transport exists, so EOPNOTSUPP reflects the available receive
paths. The receive callback also rejects any local-mode socket as a
defensive check.

In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
delivery and the global port collision before the fix. After the fix,
local bind returns EOPNOTSUPP, the global bind succeeds, and a global
VMCI datagram still reaches the global socket.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 net/vmw_vsock/vmci_transport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..282131544c42 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -627,6 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	 * outside of the create and destruct socket functions.
 	 */
 	vsk = vsock_sk(sk);
+	if (!vsock_net_mode_global(vsk))
+		return VMCI_ERROR_NO_ACCESS;
 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
 		return VMCI_ERROR_NO_ACCESS;
 
@@ -1697,6 +1699,10 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
 	u32 flags;
 	int err;
 
+	/* VMCI handles are global and cannot serve local namespaces. */
+	if (!vsock_net_mode_global(vsk))
+		return -EOPNOTSUPP;
+
 	/* VMCI will select a resource ID for us if we provide
 	 * VMCI_INVALID_ID.
 	 */

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261113-vsock-vmci-netns-isolation-7e46732dcd73

Best regards,
-- 
Sergio Lopez <slp@redhat.com>

