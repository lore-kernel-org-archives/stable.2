Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429696;
	b=AJfyjjL5OSePK5aXUPsA7q27Mit0UWkmtMKi7t4oBw4GLnwfNdymu4GQKMy33Dedz6WX
	 vKNmlibjxYO9pEX4i9h+UkrZ0wNneMKCy3sOkE/6X3IcnIsc8mvpmMf6SBfyO7sF5Xnm0
	 ngja6jlNAiyH7sV83/MwH3A+lZlcAP/FKG3W/gO8IQ4eBNtNMYdZEa265/VKuIH59okny
	 2T9Gf2au1NoBuQ5N5igZdfj40K8shOowihxZWgbtV8D4+rQH9j6IURuvH74ZYwfyPv+gF
	 jpLppzdAlrfsxyaKiZyn0Hp5WYJippHD+96iXj9XhQEwHw4c9IlC7kRuqvJf1JltnNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3z36krrHxFbBA0vLySUPeNHdYTb/OoCUAxpD0sDq89s=;
	b=L6DoFurYQBt9q+NH4ZlcqlgmAN7u4MUXx5C83bn/Pva4qn6rqSDdac+jJ2Za+bi0Mar8
	 dKPb19wq0Xu8QbOO2xmhIAvCtGW9a939bqYLsKZTQj/7HoqFbiqtlVRdRN1UwsvSA4MJt
	 HdagoY1vvbOvzPExXqehQWtRQXBFcAhwd+3VeZocQksGfGjpeMqa2XxS8El8XI9/+9eLZ
	 YhFJCWjUeGJrROq5iqDyHy1nMEMwBm/D0kY0b5RgylqhVBdbnMqLn0Cr2VFanCwoQA08x
	 tkl4CMZ2dE6nyIvYXyv8VA3qJXpQL/H1lxqvoD6ZKQeuFAdqjjIFk1qEaJtETHZk5GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=skWu3vDf;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A73606A319
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A73606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=skWu3vDf
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-353804b591eso4498177eec.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429695; x=1793034495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3z36krrHxFbBA0vLySUPeNHdYTb/OoCUAxpD0sDq89s=;
        b=skWu3vDfqt9ZfNEmYQErSE5wvG+OXUt1Wo3njPcpc5yKBzHwuNfjMZ4mHPaZLrnETo
         ywicj5rdD6spTe0RTcopWwRbGK6u+6mekURZO2q/EVB4u46xA3dn8vpwb8UqU14xKRA9
         YdIiSi53SnmL6zS7delRC3u1Zt1NeYh+kA6NeLmc6TH8XG8uL623flSvayMDY/H902X1
         7uC7brKZ/nbuyimdYVPmOIxcSDpvi85FyBt9ahRB0hoKJxg3lKHYqAua4PQZAwVA/MiD
         Bj0Om+EKrHSD7/GOIeeJZkam4lqC4/i8iZM2/Y56xstEKnY7/a8LRM7sE1/XugzyxrcG
         T56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429695; x=1793034495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3z36krrHxFbBA0vLySUPeNHdYTb/OoCUAxpD0sDq89s=;
        b=qITVojdz+fmvNdKnjZNiPJiz0OsseFbEmmAzjLa+hx7V5c1PaJgqKDRVtm7QXoQAME
         ot0PM/EWN+o/wSOxiP5Ht6O7aFHrDnUvkTk9NEozQE91XUXukTDeHTWJIVaDV8D3lwAm
         s7MugYun5wYnGyeSlxg8KB9BMCERwp2ihYO3kkbjwfW0e2E6oH6K6fAQdvgU1FZCmLzl
         i0p7slaRIY73nlwByg5BThgmBEjr4ApM9s9grwpTJMCrVZKiiCDYkVEuMoaoIwYN3B1i
         uMpqUXjkyjJgW/X0CkQ0S2f553jjGJjofl6VXO0inUMYUggOXuG5loaC6XBrsRqMN+8G
         42Hg==
X-Forwarded-Encrypted: i=1; AKwUvBxYVhlYY9ZSWfAX87WFCUVcIZdXRQroHaM5HVGWM5kC3xCbA9DTGQQTSkhsOUQSHrBClv4jzxY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzAUrNGne/iNyUbZ7IgmNKN1Bu34yVZtAN5ThqIyt9OoM+Tg1F
	DsAek417gTdi0a9KhrZ+KTZPY59LgKxx25IhCUntNkHoeD7nNy8wWr0v
X-Gm-Gg: AYBFou36K8gOL+IQM/sIJy3r0NCXJWNDvSZYjmK3UB7duc4jMK4Og1VLIbnVREdSUNi
	2U1xUqD4Ibwiuf2eqESlQYLxdkKV2m4r7VV122e16rENJf14KibhHlc7kHe6k66eWXjJsLhnFlH
	d1whmQcFD3Rnmx8zVkqz6WKZ9Mfv6+g0W3Rf1VdLU4XbEHxNCyoVysiQK33GWfYJDxNNsBN3wrf
	VhHaslEcUEzRhIBcuovsmoWSUwE6Pw23RgXKP2+c896VT5lZmorRXexdr6MdHQCcJNOCMzNzCvh
	mRBLdkL36bAre+0QeUwMA1aUkOWLJbc9ZAN/2mRmtQ6mqCncZDVVhq8J5lABAdl9n6tbUq1Gkg3
	R3dsjWZyeR6ZLPAzYMdyUjRXKx/0eDiPszNwiWN1nQBS1vOjgKPrkvKOxvm7+WdYSP93Pa/UAOo
	Y8mFDMA0+FgIvSwms4Ad7qCZSQ7CgsMIcGtfPru/eKMsn575+w9oKGd3qCJJoh/9fenp8iCu5CO
	sg9Pik=
X-Received: by 2002:a05:7023:a56:20b0:166:3e26:c4b5 with SMTP id a92af1059eb24-18512296a15mr11257108c88.18.1792429694452;
        Mon, 19 Oct 2026 10:08:14 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm29247207c88.5.2026.10.19.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:08:14 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Mon, 19 Oct 2026 17:07:51 +0000
Message-ID: <20261019170751.200446-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019170751.200446-1-w453y.me@gmail.com>
References: <20261019170751.200446-1-w453y.me@gmail.com>
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

The "delete and re-add" test validates the removal and the re-addition
of the endpoint used by the initial subflow, but without the fullmesh
flag.

Do the same with the fullmesh flag: without the previous patch, no new
subflow is created after the re-addition.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaed..4fcae963a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4424,6 +4424,36 @@ endpoint_tests()
 		chk_rm_nr 4 4
 	fi
 
+	# remove and re-add the endpoint of the initial subflow, with fullmesh
+	if reset_with_events "delete and re-add, fullmesh" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		wait_mpj 1
+		chk_subflow_nr "before delete id 0" 2
+
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after delete id 0" 1
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 2
+		chk_subflow_nr "after re-add id 0" 2
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+		chk_rm_nr 1 1
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

