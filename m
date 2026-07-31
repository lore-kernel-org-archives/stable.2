Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006EC459ADF
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515163; cv=none; b=oZBB9ev2or7gWXR+9LDV9BBZqJ8Zj2EiLmE6bmF4bdOu++qzV6e6SKmMRyb7Ma4QAnGMuMXnHWURlQdUXov+LIuOk8lJqw5QXHzb5P8LK8ICVRZr2x3T2IOCro282t2GlWLFd3TE+9+Bc5EGZ1ILPsTPpG7Rbkvr1VQOw9vJ2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515163; c=relaxed/simple;
	bh=ECK76g+9rlK+cAVr53M3Xrn1vPFCZMYT848BIFCAC68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNyEGiOzy7ss4GCNXeZE3QC85aYz4GaExjU3X/D3pr1EW8glXtTUVwpR58nmjTchJpID62rHuvurWB9qwVR42c6c6yKl3ECYtgbg8tXI537D6NfqC+C81IxcBafilAeSxiszC89qaFb7WqTRYavhgt/ZjOFT3OP34XQRiv/1ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWo6/oeh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWo6/oeh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785515160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dIv97IOLn0/ejJggLwfffj67mbRXdGHwKIKr7oQyrK0=;
	b=PWo6/oehIFca3y2ThWYbZx3FrXP6kaVt+130vJ/0GWtSFFqqs7Sozd0lnkRMZsl2wzN/eP
	mP6SysQauYMRHDZyzuKT8qMssK7THu9rRBr8qZVHZm9K/qdIUzmhgduhk6v0xT0WtdJhep
	ey1YXJugv/1/V9GKTb8FplIu/qGlCXk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-G9RTodWjOj6fEXA19gRLuQ-1; Fri,
 31 Jul 2026 12:25:55 -0400
X-MC-Unique: G9RTodWjOj6fEXA19gRLuQ-1
X-Mimecast-MFC-AGG-ID: G9RTodWjOj6fEXA19gRLuQ_1785515154
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FE37195608D;
	Fri, 31 Jul 2026 16:25:54 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (unknown [10.2.16.63])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AB281956047;
	Fri, 31 Jul 2026 16:25:53 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: stable@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Brian Grech <bgrech@redhat.com>
Subject: [PATCH] selftests/net: gro: use variable sleep to handle slow environments
Date: Fri, 31 Jul 2026 11:25:50 -0500
Message-ID: <20260731162550.4112730-1-bgrech@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The server socket initialization sleep was hardcoded at 0.5 seconds.
On slow or heavily loaded machines this is insufficient, causing the
client to connect before the server is ready and producing spurious
test failures.

Respect KSFT_MACHINE_SLOW by extending the sleep to 2 seconds when
set, consistent with how other selftests handle slow environments.

Note: tools/testing/selftests/net/gro.sh was replaced by gro.py in
mainline after v6.12. This fix applies to stable trees that still
carry the original gro.sh implementation.

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Cc: stable@vger.kernel.org  # 6.12

Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 tools/testing/selftests/net/gro.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index aabd6e5480b8..c4ed09e5f002 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -21,12 +21,14 @@ run_test() {
   # Each test is run 3 times to deflake, because given the receive timing,
   # not all packets that should coalesce will be considered in the same flow
   # on every try.
+  local sleep_time=0.5
+  [ "$KSFT_MACHINE_SLOW" = yes ] && sleep_time=2
   for tries in {1..3}; do
     # Actual test starts here
     ip netns exec $server_ns ./gro "${ARGS[@]}" "--rx" "--iface" "server" \
       1>>log.txt &
     server_pid=$!
-    sleep 0.5  # to allow for socket init
+    sleep $sleep_time   # to allow for socket init
     ip netns exec $client_ns ./gro "${ARGS[@]}" "--iface" "client" \
       1>>log.txt
     wait "${server_pid}"
-- 
2.55.0

