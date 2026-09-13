Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAD331209
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331502; cv=none; b=lW1NMakmR855evk8pLfNXHwcGOePRp81vQmk+rE1XcDVfCCdgFwRn1fibSZ1cCOZoxj3/KHK61GyMeV6V4MhtgTpzopj5Z8d2JsaTmYSM/7PII8InJCqb/77DwlFPMZAfUJzqIhI7mIq3xbvJyJPvbFLBSywk/AaVKeuPYXGxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331502; c=relaxed/simple;
	bh=TCDyOJseK6qPBPCx1hp8gZvbnaru+qTNFkWXDDYtmTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzQJwRA5gWld3JsOcEDL9P0LEkzGFLvGEc5c1anOKSS71cLlaiEQhMP49MjpgBN+WfYv40ebnDSpXYb2MkgtzJptAiumk39uO3nFiF+N83MLMu9gXZMwulEVIkn5Aze9ai+TPgse88spXTpfAdza8piX1j1KM4fBSbKSrROooAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/dJ0OMY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/dJ0OMY"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso1129531a91.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331500; x=1789936300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhR7p+wss/jt6zjE9pDS80Sv1ZxId2hdmHkP0DmuGW4=;
        b=F/dJ0OMYCv/BbXBbfgVtRuW1ei2HjYvfeE7x/S34wTEkXQQ50aC3qr8a37jZynAIPr
         5zRbvMyuyVbeZqDEsPHjlSKKhbexhz/F+l5ifP+zmRQ2Nn1xqj/POIf+2eX/D/3EB3Jh
         AhEUZLFlg8aad+b4Z5Gti7DEwJOpQp4ImOvcWv04Tnxw84qvCnP0aILHsAuoNj/lGelG
         3I4G2sn9eMK3dWJAy/wd01wFXWACdOOpGebNyPgOte8tpw7wigIa094sdOKgAfGuie47
         6aSqd1CAeiY3W2my5XKYvRw6lp+XQLFaZ4aXMkP8Kqhf5nYDStXsaXd9kkDzQQeiUUN9
         RN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331500; x=1789936300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhR7p+wss/jt6zjE9pDS80Sv1ZxId2hdmHkP0DmuGW4=;
        b=PF5LdJxl8p42Y5AYFNaf3bg/UP+1r6MBoJxsQZKsgl0LDFz8VgKSSVCXu3bBk97PCi
         HDgYzcDf84eTkJ4dNVucLudJduguPOwiTPlAYWUjZCPngslSBmY8Prc7Lvhja3qVDWiW
         INAeC04VmDchICiq8IMAsI960C78KIXqGeyXarvMtccX02WwtYULvf9ism/ODDDqXas9
         bienWnjuMFQ/s1BmF6LbUzNINlhr5SQN7M2S7mAl+rfzyq8GFpisV1i5Z8QpuZhZFpFi
         jqWndi35jH+YCw2BRHGOCmAzEUWLGwnlDccUkbWePwLA/EecsmalDisSyzlcbpdt11kM
         63ug==
X-Forwarded-Encrypted: i=1; AKwUvBzvpxVt2AdUNsc+BRLj4NixKreOMWozWtk7aWU4Z7OagAxcJ0ACyVDXSMRU/cN/P1758yZ4gBg=@vger.kernel.org
X-Gm-Message-State: AFuF++lXthejVpGbo20hplDqXVnZ3dFAWK6vej+dFnR7W704J1vrM6yW
	gHhmgOc0WjQjSYqn85eu2baH/fsKsYxeu5UkaAvx38e3RH+CfpSXmag=
X-Gm-Gg: AYBFou2whQmy2AGxwW2glGEgA8/YI6dq3aya0+COKhkevhZf9YuX0S1IciLk0FyuvbB
	PIGhUinXKLguZiMXNH1inSe2AgINN77CmzN7jQMY78hTH5d/5bBKcLu6YGP/gB7LgB5ycRbTkLh
	vid9UDowxyX3XhGhMtj1KfKmbGwX20LFLgDmnOfQH/Zahffhg9J8zkcC574PThnfuS0nMD+NCg2
	1feMlqfPpmkP4tJa3+3Vd+XbdOSe9Dbgev83m+RsyVBoed23eij17s79uL54EAA9up41vtv7u5E
	rBnZFNvvW1mhtC+Xt4YviB5XKnZP9SCaQ91CKOLyh/d+JQVWqdwxnkfQkgTF0bwWrhZNEFNCXUr
	UmwOg5/IK3DYc3wkHOJSMEQnWaCHhjO9AMnQuOl0VQeKfLfld/JmK10WoyJus/tD8/EuA2g/WIt
	8mEBvJcHmGRcbmM6++LROn8JV7iHM78jVDRstGzEQBoGJMmKZR5v705HChUSYxwB99okIhaLymz
	21VHaJ+Dw78raSrFdBiH7ixQg==
X-Received: by 2002:a17:90b:2246:b0:39b:92bb:9eef with SMTP id 98e67ed59e1d1-39dbc6f8b29mr15621791a91.22.1789331500331;
        Sun, 13 Sep 2026 13:31:40 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm17530220a91.0.2026.09.13.13.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:31:39 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: Add the bucket size to expr_field_str()
Date: Mon, 14 Sep 2026 05:31:28 +0900
Message-ID: <20260913203129.941270-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
References: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

expr_field_str() renders a HIST_FIELD_FL_BUCKET field as "pid.buckets",
dropping the count, and parse_field() rejects that spelling.

get_hist_field_flags() returns the bare string "buckets" and keeps the
count in hist_field->buckets. hist_field_print() appends it,
expr_field_str() never did. Nothing reaches it today, since .buckets is
refused on a value and no expression can carry one, but the next patch
renders histogram keys with expr_field_str(), where a .buckets key is
legal.

Append the count, as hist_field_print() does.

Cc: stable@vger.kernel.org
Fixes: de9a48a360b7 ("tracing: Add linear buckets to histogram logic")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..9d7ce01fda36 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1755,6 +1755,9 @@ static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
 			seq_buf_printf(s, ".%s", flags_str);
 	}
 
+	if (field->buckets)
+		seq_buf_printf(s, "=%ld", field->buckets);
+
 	return !seq_buf_has_overflowed(s);
 }
 
-- 
2.53.0

