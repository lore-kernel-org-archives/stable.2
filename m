Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018645;
	b=XxMGp5egRL2VwLwZAAj3GCvYwS5hIvlyI7VDqEtVmxZHt2/P/HmMX53KJD2YUlOsGK8/
	 Uz7DNEOCxnC0ERIFPllpuxl1AbbSEHzq0YYPhZqzTfD4mxEukNx9BpspZ/Ev/aGbTILq/
	 AflkTj7mGmz1sDPEv0UoRImjDOlLOHDQfOJoji5QvI8cCwuV0gdubK9OOcLxFiQ7xj61K
	 gjKf2cdDL9QlJi/+NwhuoodlfzH7SXpDnjKfqXojRJV5eq+8+e6igO2ICfwSGR+N/ciN6
	 oioUBA4PmUhVO5nzgixzVn56gz9Od8b1la1nhy5A0CS7aPxkAzRxUl/1P7ZF1wgHhHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018645;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=uHLlke/0QwEj0e5IfuczaISxPb3MEIUdWSdyMZi2tkc=;
	b=EIdkHDQW3ldlqN+2WVXrzIybjfaVdmZFOSFTra7wLEoi9AYrwZxFD5GetdAAXdxdVzFo
	 kRzyq/n3yr0zjnRhvcnfu+FEaaD1VzfqfHi8TjxTphdwGca2WSwjgJDM/HFG3KiDL9ACN
	 T2/IhUnnZDQpP5VmEk20TTbZgnYID3HKnCFZzraKBKwyPtfAe+iwMzTsWE/kVNDGg8tPK
	 gaBx79JgUmXrc3Yz39gy78tJqHqNlxmQvWGUzhivRYFa+o6db864jv/iGbrsHo3bVUpPi
	 +1CBuOjagpcjUbp8giokCngxxRSnWT3XdXU6SkGpogBSmHsC4SzJmHx1XtEF2Or9s+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="E//KcX4j";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDD60A2602
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72DDD60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E//KcX4j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793018644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHLlke/0QwEj0e5IfuczaISxPb3MEIUdWSdyMZi2tkc=;
	b=E//KcX4jANXjgTCAAhTvi7t7YcL2EoNlfc4wsT3f3JENmpwtvlNJo7vCg4Ot0Ji/mZLRG/
	tdRbwSaLtWLzgrW7j2+pvrWvTHBXrxf2pUWBIC53IBolN5gyi2sBhvK5LWaRwM7uaypaDQ
	rBCKhtoQUnhxbup0zXWVoj3hEjMCQjM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-l-HmJhBPOnSEgthlh_uwoQ-1; Mon,
 26 Oct 2026 08:44:01 -0400
X-MC-Unique: l-HmJhBPOnSEgthlh_uwoQ-1
X-Mimecast-MFC-AGG-ID: l-HmJhBPOnSEgthlh_uwoQ_1793018639
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8AAF1801319;
	Mon, 26 Oct 2026 12:43:59 +0000 (UTC)
Received: from loberman-thinkpadp16gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B1C8195608B;
	Mon, 26 Oct 2026 12:43:58 +0000 (UTC)
From: Laurence Oberman <loberman@redhat.com>
To: mkp@kernel.org
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	mlombard@redhat.com,
	michael.christie@oracle.com,
	bvanassche@acm.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/4] scsi: target: iscsi: Claim the completion in __iscsit_check_dataout_hdr()
Date: Mon, 26 Oct 2026 08:43:43 -0400
Message-ID: <20261026124344.745124-4-loberman@redhat.com>
In-Reply-To: <20261026124344.745124-1-loberman@redhat.com>
References: <20261026124344.745124-1-loberman@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit d5869dae5080 ("scsi: target: iscsi: Fix hang for aborted
WRITE_PENDING commands") made __iscsit_check_dataout_hdr() complete an
aborted WRITE once the final DataOut PDU for the last outstanding R2T has
been received. That call records nothing to say the command has been
completed.

target_complete_cmd() on a command that already has CMD_T_ABORTED set goes
to target_cmd_interrupted(), which queues target_abort_work and returns
without setting CMD_T_COMPLETE and without changing t_state. The command
therefore stays in TRANSPORT_WRITE_PENDING and on conn_cmd_list until
target_abort_work reaches iscsit_aborted_task(). If the connection drops in
that window, iscsit_release_commands_from_conn() finds the command still in
TRANSPORT_WRITE_PENDING and completes it a second time, which
re-initialises and re-queues an se_cmd->work that is already queued.

Route this site through iscsit_complete_aborted_cmd() so that the
completion is claimed and connection teardown leaves the command alone. The
helper makes the same iscsit_stop_dataout_timer() and target_complete_cmd()
calls when it takes the claim, so the completing path is unchanged.

Fixes: d5869dae5080 ("scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands")
Cc: stable@vger.kernel.org
Signed-off-by: Laurence Oberman <loberman@redhat.com>
---

Notes:
    This depends on patch 1 of this series, which adds
    iscsit_complete_aborted_cmd().  d5869dae5080 has been backported to 5.10.y,
    5.15.y, 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.2.y, none of which carry the
    helper, so a backport to those branches needs patch 1 as well, or the claim
    open-coded.  Happy to send a standalone version for stable if you would
    rather not carry patch 1 there.

 drivers/target/iscsi/iscsi_target.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 3dad7f6..83184de 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1533,10 +1533,8 @@ __iscsit_check_dataout_hdr(struct iscsit_conn *conn, void *buf,
 		 */
 		if (se_cmd->transport_state & CMD_T_ABORTED) {
 			if (hdr->flags & ISCSI_FLAG_CMD_FINAL &&
-			    --cmd->outstanding_r2ts < 1) {
-				iscsit_stop_dataout_timer(cmd);
-				target_complete_cmd(se_cmd, SAM_STAT_TASK_ABORTED);
-			}
+			    --cmd->outstanding_r2ts < 1)
+				iscsit_complete_aborted_cmd(cmd);
 
 			return iscsit_dump_data_payload(conn, payload_length, 1);
 		}
-- 
2.43.0

