Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272621;
	b=TM6JNWYXvdG2redD5DpQlmqCSahZDceKqtSot6wrG6pWUm+po8NS0Gz/+z6CH7TTI49y
	 8ULYMxfNk1wSdbiEr3kEMGFfQasvJh/eBBPbqPVA6HZiGRWBD5yjK5I3MXSB5qGPeaQYA
	 n73PR1XIk6B4sNgdxybzDJWdAf88Ql4LqLym3W67mJdhaBco4QFn3ZHdlN9edxESe+OLO
	 GVweldd4WiLwzOsv+BN4DIgyu1bx/0EyB7hJ4mV4E848YVJzrXkQ3c2NrzVBSAyrtQQ8c
	 1Xc05jAPBUBJX5SCEHgq19Gay+VxgMvdhJ2/UBxLBuIwrRQCsvSCp5YUQFJdBMXKgZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qcHvp0w5ArLZSTEtbl8CEu/NVqZsXzTy32wqj05S/oI=;
	b=y/Wh4PzEDgb/AHHZQ6pcPvjRYE6eGPrcEfcbMmPZ5T2U6P8GKldls34SF/yDkPARy+81
	 15vNYQJPX5PtJ2v+b61FNG2H6BL3WBl/XsQySQ9e5r7WUjeuo7uWVFHS1aGsUFQEGkA9i
	 PGEp5zguRUxJaQ+Zksw4hg4sO5k/ENjkUqcqdo7HcAz6GhhRjwbO1X6QB60F5jSSOprz1
	 YLohuBnRmmSvwwziGBOz2OjQitDnZ/V+FJ52QGgcmz49c1d9CD2nuFqHxBUdpAGEwdm1R
	 X2CtWj+//5sLQ4DuyLsehiLOg62pz24o3723dDtCK4xW1MApj+AgXoVvZNzBYtF7PzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMS7qFb0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMS7qFb0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FC81F0089F;
	Tue, 10 Nov 2026 01:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272620;
	bh=qcHvp0w5ArLZSTEtbl8CEu/NVqZsXzTy32wqj05S/oI=;
	h=From:To:Cc:Subject:Date;
	b=KMS7qFb0fyYh3Y3JH+eLsFJwcyWrLaLqFGf1h+wble4MPwLdDgEgknRbpe4zwP1iA
	 fdRbn3MYu3VUCdNk1e1wx44JB0PDxGEQVIhsaZ9Pi65VwW/sqNLsxrypmc4LEUJsis
	 G/JSE8z0T/7I/rUn5riHhJ92sXzGKFggSt206XypBQPu1jDpVKbu+Jllhzgl/e8wdj
	 DUo97GBjsAXj+PmkdVpSMVQCWgMwmDv1l0R+zbT6eMcwavgWcWPzlCQ/PaIhO1nWOS
	 ST803KBLGGnAaRsTYm8RuUgwT/4EYtD4J9QR41cn4J3kTr8zAznM7TpicJM5uIQZZY
	 Tz5Au+zjuw59g==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net,
	sashiko-bot@kernel.org,
	ycistak@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Set nr_cores only after core_data allocation succeeds" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:39 -0500
Message-ID: <20261109200339-failed-6.18-95638f1f05ce@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 95638f1f05ced75a82e83f610cd01b636d2a21b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200339-failed-6.18-95638f1f05ce@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 95638f1f05ced75a82e83f610cd01b636d2a21b1 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 31 Oct 2026 03:08:32 +0000
Subject: [PATCH] hwmon: (coretemp) Set nr_cores only after core_data
 allocation succeeds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In init_temp_data(), pdata->nr_cores is populated from
topology_num_cores_per_package() before allocating pdata->core_data. If
that allocation fails, init_temp_data() returns NULL with
pdata->core_data still NULL and pdata->nr_cores set to a positive value.

coretemp_add_core() logs the error without failing coretemp_cpu_online(),
so the CPU still comes online with pdata->hwmon_dev registered. When the
CPU is later taken offline (or the module is unloaded),
coretemp_cpu_offline() calls get_temp_data(pd, cpu), which loops up to
pdata->nr_cores and dereferences the NULL pdata->core_data pointer.

Store the core count in a local variable and assign pdata->nr_cores only
after pdata->core_data is allocated, preserving the invariant that
pdata->nr_cores is zero whenever pdata->core_data is NULL.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 1a793caf6f69 ("hwmon: (coretemp) Use dynamic allocated memory for core temp_data")
Cc: stable@vger.kernel.org
Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index eb74ecd12310a..7fced0e2abeba 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -491,11 +491,12 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 	struct temp_data *tdata;
 
 	if (!pdata->core_data) {
-		pdata->nr_cores = topology_num_cores_per_package();
-		pdata->core_data = kzalloc_objs(struct temp_data *,
-						pdata->nr_cores);
+		int nr_cores = topology_num_cores_per_package();
+
+		pdata->core_data = kzalloc_objs(struct temp_data *, nr_cores);
 		if (!pdata->core_data)
 			return NULL;
+		pdata->nr_cores = nr_cores;
 	}
 
 	tdata = kzalloc_obj(struct temp_data);
-- 
2.53.0




