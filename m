Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296668;
	b=fRajIdQtc/Q4Nacix7cJ+4SSp5mTcfGEhJIYZB4ACLNOlrzOBE7oXiGT01vs1czUwvq2
	 PrBoH97uW/Y+Pur7jtYWdsoqr/Cs+vkvsFkGSCmdVquE72VKvf4XlJ+AO3tQURDZPlql6
	 8sBHw3mfKKL4tBgUWZtE6m1ybJVRJwNc36QLlPuPdLWUndgy/Sf5HRAASa77V7F5gCCOD
	 1FepmmtJS9l+r68M1KukZ8wGzfrAfzmcW4dZNIp+PFBFrnhjOXlxzULOGfpLmFxIps+qy
	 Jm9wPKO47NLJ8bV9eLc2jegbEw2oRvTMowxxmyqd8FLGxnMO8DjzBslOAtnuIZKFuPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S97ULSIGGgJKAMh+U7+sSDqPn7W8GLiCd95pTfSgMAI=;
	b=1wtbK2QHqY7ELmhLDQbkc91OFwelbnqzQQp1sq6UPYbJqmPDj+TeGX6j6pjtlPYJGgkM
	 74Aaf9dRqYlGXtCkaaVgronWb7FeWX3yfHvd/tk8ThmlAAItLcW5u+W+bhZVJDc6tyC+1
	 3cAxp7u/Z/a14eN/g2+FukemgFB/O9os2Y2bixrTWIt0I+w9HxoKWaQexuAxvpdn9pkHg
	 VJzLQU8v4hGRyRwTj3CyZzsCmJ+LxHKhK8cpHUlAVcs2VoYwjF2NF5hWGXhJs6+BrTGLx
	 y5UvKvzksIuGkcWLwizHGLQl/X42Jdb5EarX+B1tKgqAx7xXy/Wt58YJhzMZBTbRB6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WM2CEPPV;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EB606A33B
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 494EB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=WM2CEPPV
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-71aea92f666so1379001eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296667; x=1795901467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S97ULSIGGgJKAMh+U7+sSDqPn7W8GLiCd95pTfSgMAI=;
        b=WM2CEPPVe7a/CB5WkhpHaEZ6nxkn0I+6Q3kop2ve2d156Zm7c9XFNpddIgGC7z+SmV
         2Z7zSseSVwsHZAUje/aKwWqzoANVPkuZOf1UVm/ZAw+lHryfQGxzST61TXVyGKMY+YON
         iwLJGPv6tTnNQVJt+o+mA56e+tGt6DWr6SND6B47Ru/I5xC3uTzVWTeI/cWvus7446Ot
         BvNyinKW9PcX/yc51jf4zpz5HUf5FPP5swL0QwDGQmoCu8IJ9H7erG7PL1Uao2G7vYQ6
         cowwP1RNJZHSI5yYa402W+CBBgryxryfrGiWDwLmpwYe9KyKPgACA12/Ke9FqUhM7f9Q
         ymXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296667; x=1795901467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S97ULSIGGgJKAMh+U7+sSDqPn7W8GLiCd95pTfSgMAI=;
        b=XmL0DpWbgVeMZRWIi2IQ0VOZ3sHrjCco/yUJU8BSCueRyplYYNTjGyYEA3701POuJB
         c10D14ppdrWPIV3WsMZQJh7Qt6Jq1G4JCGGTttO+1xw/fnUEz7arPYu1VahVQL1Muocv
         Lv4X7NvLmpuf1LM7Nu31hqLdy2VuwC7Q5shmuyRby3ziF9VcQMs1Zg9it9Vj49OF27xt
         E6WoMkT0TCe4wrDJoCZF66ZpBPLlKdMxkf1tZ1nYkva9cz8OLDBTtSxEgb4zuiIuNUs1
         Gu3WBu4pw689aZZhC9CQmc+2p845qx44FyXlqueyeSRVkV99OgVko7VmSq2IJ0oVVTnT
         3ikQ==
X-Gm-Message-State: APuU4Z9uyQjEjxIo0copPQ2AuhLdLKx4zAEdu5kxFzZe5xjaIbXHBRls
	NIIrM/c3orfxBSvwRoPIh4T3ebww2t/xKmGjOM+tZD79JpZtFvaYY7rl7Nc6ia+FVpKV7auQ7a0
	AiHHDw1w=
X-Gm-Gg: AZFdTZedN+goWl6XeBMWRUVoNDMn7lB4MSGxLXwmac/1S3VbDlcvEzY7mbtY8MsE8K3
	w4N5QmDnRon84KAKJUp23A9fbNEPuDjmqTa7y3N2tx8nJXlt81cBK+W9J8ULs9cxjrY9Ylb55DN
	Mya44sgfE4HGpgzh5SR6ZFclQOEXzFGjISTro1C1szzEveKdhIbAvlm3XLez/DFNRuIBMmmyMTD
	TSNFYpBUodjq7PJT0TQ8BizW94irOsvKYBxAZ5jwk9qEKoMrZZ7ScqvL5hL3uYqeHKlh7ppu1H/
	+TGsoCc8aJEMcJfPubMAfYB/133bOYZs5Nw1UIyBqiEDjiWak0rk3MKYAIzFADYMtcR5g71GaRw
	SDeeaGvyjtsGPNtKbMq6uyC5VPqzm0yMIqnNyaNlwOy1RNRqje7F6kL2v32ggRhwe6sprYGCMmY
	t3ivTEZbH6b83NIxgEmaGNs/XlOnvX9gDZ8x85/OizUgp1noaUwmp7terJcBhqyhxZhE7DtfNgh
	O+IXT7grvuYkQqDMxhSTsCG5koP3wwqDL8Hpvw4sSX+S9QGqE0DB9HjCNvOaVCdqgdLL+uoAUrm
	5fNEzJvnc0etfbYSEHjbc88FObjAhrb71vlyJDqf3+nWF/sVw+uPESzNm1axMsTAySc5Fw5VARN
	d3SGpd5UgyVJOkDeWOnRhAFCOY8XMh1ncdq37
X-Received: by 2002:a05:6820:1344:b0:70d:d3a7:24bd with SMTP id 006d021491bc7-71b394dca33mr5175620eaf.49.1795296667247;
        Sat, 21 Nov 2026 13:31:07 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 12/19] io_uring/sqpoll: ensure that normal task_work is also run timely
Date: Sat, 21 Nov 2026 21:30:42 +0000
Message-ID: <20261121213049.1788332-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

Commit d13ddd9c893f0e8498526bf88c6b5fad01f0edd8 upstream.

With the move to private task_work, SQPOLL neglected to also run the
normal task_work, if any is pending. This will eventually get run, but
we should run it with the private task_work to ensure that things like
a final fput() is processed in a timely fashion.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/313824bc-799d-414f-96b7-e6de57c7e21d@gmail.com/
Reported-by: Andrew Udvare <audvare@gmail.com>
Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Tested-by: Christian Heusel <christian@heusel.eu>
Tested-by: Andrew Udvare <audvare@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 3849252f6135..b1428f91b5ee 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -253,11 +253,13 @@ static unsigned int io_sq_tw(struct llist_node **retry_list, int max_entries)
 	if (*retry_list) {
 		*retry_list = io_handle_tw_list(*retry_list, &count, max_entries);
 		if (count >= max_entries)
-			return count;
+			goto out;
 		max_entries -= count;
 	}
-
 	*retry_list = tctx_task_work_run(tctx, max_entries, &count);
+out:
+	if (task_work_pending(current))
+		task_work_run();
 	return count;
 }
 
-- 
2.55.0

