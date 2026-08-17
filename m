Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B443A7843
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992408; cv=none; b=QxRMm0yekHjyR/OdUFnyRPn9m/1rbROJRWyKuyUyFZhU/UJY9X5tZDji19jGhbV8O8uguTbxBzKPlL/JqGmujNq4akyUpemJLOqovixTv+ClCwMFpiL9AuV/RDau1eASwlgbSU+bD53i3soNpr/wb0JRpUZJj/dIJgz7SeeaPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992408; c=relaxed/simple;
	bh=xVmHJlFrQrU+BNvTVmBFyd8+1yfvVnB4Cal9+GCRYxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQmPwzcYLNEsgpJ3v2jsCxUODlfLdr8Rot+gb3uRthFsUa+JZLnC1hE9EKHaTOwBrOzx01kMunUKiU3oAW8EyRlVd70esS767KJYyM9C+wjt1e+IovrPGQMDq4YvjxSL/gdEIKT5YD19F14ZlMbI6BWkDUUMvOnmW2y7ZCu1iJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjbMjRlC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjbMjRlC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786992406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4GlCflkteeelg4VY0ysidlGum1huGIUMb9+9VM+1VjQ=;
	b=BjbMjRlCEcXpm9FWq8MuZMLcGXKwDtow/2P8/o6PCYU2rqVB33seDcrpjZuYyjzBnhe5/D
	VJIsCpthv8yRzaM1YZjMTTmgBWZUJvKDk9LSb2cvC4Bdud/EKcJsb8qqBokOMvFd8OPvNU
	AW1xgnodfF81fE/I+KvuCUn68Hg9r60=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-MqdoLrTVN7SVLsg8DO9jFg-1; Mon,
 17 Aug 2026 14:46:40 -0400
X-MC-Unique: MqdoLrTVN7SVLsg8DO9jFg-1
X-Mimecast-MFC-AGG-ID: MqdoLrTVN7SVLsg8DO9jFg_1786992398
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8254E18007FB;
	Mon, 17 Aug 2026 18:46:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68590423;
	Mon, 17 Aug 2026 18:46:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Bongsu Jeon <bongsu.jeon@samsung.com>,
	David Heidelberg <david@ixit.cz>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: nci: Fix wrong size of status variables in nci_dev test
Date: Mon, 17 Aug 2026 20:46:33 +0200
Message-ID: <20260817184633.324615-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

pthread_join() stores the thread's return value (a "void *", i.e.
8 bytes on 64 bit computers) into the address of "status", but the
"status" variable is declared as "int" with only 4 bytes. The extra
4 bytes clobber whatever is adjacent on the stack, which could
silently corrupt other local variables. Use "intptr_t" to declare
the "status" variables with the correct size.

Fixes: f595cf1242f3d ("selftests: Add nci suite")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Add "Fixes:" and "Cc: stable" tags

 tools/testing/selftests/nci/nci_dev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nci/nci_dev.c b/tools/testing/selftests/nci/nci_dev.c
index 312f84ee0444f..4e7a5856f7ea3 100644
--- a/tools/testing/selftests/nci/nci_dev.c
+++ b/tools/testing/selftests/nci/nci_dev.c
@@ -6,6 +6,7 @@
  * Test code for nci
  */
 
+#include <stdint.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
@@ -404,7 +405,7 @@ FIXTURE_SETUP(NCI)
 	struct msgtemplate msg;
 	pthread_t thread_t;
 	__u32 event_group;
-	int status;
+	intptr_t status;
 	int rc;
 
 	self->open_state = false;
@@ -497,7 +498,7 @@ static void *virtual_deinit_v2(void *data)
 FIXTURE_TEARDOWN(NCI)
 {
 	pthread_t thread_t;
-	int status;
+	intptr_t status;
 	int rc;
 
 	if (self->open_state) {
@@ -585,7 +586,7 @@ int start_polling(int dev_idx, int proto, int virtual_fd, int sd, int fid, int p
 	void *nla_start_poll_data[2] = {&dev_idx, &proto};
 	int nla_start_poll_len[2] = {4, 4};
 	pthread_t thread_t;
-	int status;
+	intptr_t status;
 	int rc;
 
 	rc = pthread_create(&thread_t, NULL, virtual_poll_start,
@@ -605,7 +606,7 @@ int start_polling(int dev_idx, int proto, int virtual_fd, int sd, int fid, int p
 int stop_polling(int dev_idx, int virtual_fd, int sd, int fid, int pid)
 {
 	pthread_t thread_t;
-	int status;
+	intptr_t status;
 	int rc;
 
 	rc = pthread_create(&thread_t, NULL, virtual_poll_stop,
@@ -816,7 +817,7 @@ int disconnect_tag(int nfc_sock, int virtual_fd)
 {
 	pthread_t thread_t;
 	char buf[256];
-	int status;
+	intptr_t status;
 	int len;
 
 	send(nfc_sock, &nci_t4t_select_cmd3[3], sizeof(nci_t4t_select_cmd3) - 3, 0);
@@ -860,7 +861,7 @@ TEST_F(NCI, deinit)
 {
 	struct msgtemplate msg;
 	pthread_t thread_t;
-	int status;
+	intptr_t status;
 	int rc;
 
 	rc = get_nci_devid(self->sd, self->fid, self->pid, self->dev_idex,
-- 
2.55.0

