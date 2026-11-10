Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291246;
	b=Vvf8qIoAtifW4c7imQwhIpnGiuXoETckpfTL7svHhuojKkGROkFdEl7QY+e4aEapuaQC
	 slVNMy0hZmTcoEfoxkHRjREkFKjJgU5Kk2TbkYrpWjj6LKiL+5hF0rPrBVvhE56/TZDce
	 VVAnCozYlk6w01NPXpMzISVv/WoweTXIQjUPCHKnkV6eJlY5OGAiERnh5ww739k2B4t5W
	 a/q1VhSY6jcVrwrHtmZI4CnVVR1+uTYE6EK+a+Z/yCkadOkihc5SmGq05b5n3f/Pc0gfu
	 LmYCPuCt0sbNZfl1v4OFd4dB8zwH51Kf3unBOUarlpXClvH8jMbZQIHMvcydyWqmfZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291246;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=az9dHO+ROffgYCcGeIX8xLKy0nQpBMBrBMgW/jIJFOA=;
	b=0hTOONFGcEOi2Mwuh7aDVQprbupe7Ak5EH/j2N/ahhHOMZE77iWtHPPEUDSvSR2fBmJ+
	 YHqN2hCrLNbcEB2bclN5W1gGWTCBFVpd43qdIMZ3rf5R5S2KnsTn38Ok3SdNQMnLc0FnF
	 2KtoH3vsOKnqoDItjgVK0HIGHEWIiYF2+Qm0v1qLpYrxQNzqSrw73rGqrpZdUpP4/3iNn
	 92W6p7mGiyzrZx55VSoAcMAmAP4Y/39GrF8BqNi+mc0nwrgXExqmCLcdTan8EGl2pJOgs
	 sw4aJ77KSPolQ4DRTclOKxAfHY+PqobKOnwV///26Y5NKwFiFuDhhgfCHZbY445SLCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.50
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD0606A31C;
	Tue, 10 Nov 2026 06:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76AD0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07487006|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00782076-0.00132703-0.990852;FP=810859280924206831|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.k-d-.Og_1794291234;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k-d-.Og_1794291234 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 14:13:54 +0800
From: Wang Xiaolei <wangxiaolei01@kaihong.com>
To: mwen@igalia.com,
	mcanal@igalia.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	tvrtko.ursulin@igalia.com,
	wangxiaolei01@kaihong.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Iago Toral Quiroga <itoral@igalia.com>
Subject: [PATCH] drm/v3d: Fix double free of query arrays when extension parsing fails
Date: Tue, 10 Nov 2026 06:13:41 +0000
Message-Id: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3d_get_cpu_timestamp_query_params() and v3d_copy_query_info() - the
latter used by both performance query parsers - free the query array on
their error paths through v3d_timestamp_query_info_free() /
v3d_performance_query_info_free(), but leave query_info->queries
pointing at the freed buffer.

The same job is then released by v3d_submit_cpu_ioctl()'s failure path
(v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
v3d_cpu_job_free()), which calls the same helpers on the same
query_info. On these error paths query_info->count was never assigned -
it is only written after the parsing loop completes - so the syncobj
loop runs zero times and no syncobj is put twice, but the
"if (query_info->queries)" test still succeeds and the dangling pointer
is handed to kvfree() a second time.

Every failure inside the parsing loop takes this path: -ENOENT from
drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
kvmalloc_array() in v3d_copy_query_info(). The helpers are shared
between that error path and the job release path.

Clear the pointer once the buffer has been freed.

Fixes: 0e50fcc20bd8 ("drm/v3d: Fix potential memory leak in the timestamp extension")
Fixes: 32df4abc44f2 ("drm/v3d: Fix potential memory leak in the performance extension")
Cc: stable@vger.kernel.org
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Wang Xiaolei <wangxiaolei01@kaihong.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 1924e3440dc9..a96023b5dce0 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -106,6 +106,7 @@ v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
 			drm_syncobj_put(query_info->queries[i].syncobj);
 
 		kvfree(query_info->queries);
+		query_info->queries = NULL;
 	}
 }
 
@@ -122,6 +123,7 @@ v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
 		}
 
 		kvfree(query_info->queries);
+		query_info->queries = NULL;
 	}
 }
 
-- 
2.34.1

