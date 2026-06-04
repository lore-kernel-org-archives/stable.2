Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3231E855;
	Thu,  4 Jun 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585930; cv=none; b=Nz7kaLnTr3OvGxA1eeF9gN790Z3Pevw9mDnvTb2b8PptjGzGxY3rdmrhabMbt/aKR3+fOos1AKLJ8jBS0Ck68mwzh9OBtx/CPD14idmZ4CmqYg+0T8AbrU/70f/CqtRW0C8hf2aRPNr5nTmyjeCFciCzODPJmYcd9CeoMwLyHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585930; c=relaxed/simple;
	bh=47wlaK0EI6ATGlc81zKGMp1PTfHfE5vp7D959NnIcvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTFhyFeW5BuxGU/ikxCdNw73i0nxw7E0ORwh/hKGeJ70c85tgebevqXmYbKo4V99tV99I+KnsPs48rKv+ps9f642x7gbo2FoDTafTxPr7h7OChnjBX3N67v2+kTfbiHBGeHgpszTuHe4JJcacScuiikeml5A/L+37yzYlTZOjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=V2gRai4o; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="V2gRai4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=SmTIT/jYMh661FibnFVoSvg/d5Av5bqbbb
	+ze0uVMXw=; b=V2gRai4otw1OnFDLchJLwXAfCEglie1jz8sDpshhBw7mUF019w
	aPkK+rQ73M4GB9kiXBNUpzUo9WOPGTF+PAvcGD22M/Z+I94l9DMVM23ksxs29VTc
	5eOBjrOAk1NxUOAXPrnkXew4RWOqosE/bvgDCI1ZtAcQe14gpGPHzVrZs=
Received: from dumpling.. (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQDnnr65lSFqvf8mAg--.4748S3;
	Thu, 04 Jun 2026 23:11:55 +0800 (CST)
From: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: dxu@dxuuu.xyz,
	Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Keep dynamic inner array lookups nullable
Date: Thu,  4 Jun 2026 23:11:52 +0800
Message-Id: <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
References: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQDnnr65lSFqvf8mAg--.4748S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr47Ary3CF4rAF48tFyUAwb_yoW5Wr1fpr
	s2gF9rJr1kZa15W3y2ya47AF1Yka47t342kr4rG3yrArn8W3Z8XFWUG3W29a4ayFWxJw4S
	vF42vr9Yka15JFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU4uc_DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQAIA2ohcr875AABsS

An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
inner map template. A concrete inner array with a different max_entries
value can then replace the template.

After a successful outer map lookup, the verifier represents the
resulting map pointer using the inner map template. Const-key lookup
nullness elision consequently uses the template max_entries even though
the runtime helper uses the concrete inner map max_entries.

Do not elide lookup result nullness for maps marked with BPF_F_INNER_MAP,
because the template max_entries does not prove that the key is in bounds
for the concrete runtime map.

Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness")
Cc: stable@vger.kernel.org
Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4d..bffe12d0bb289 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8471,7 +8471,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool can_elide_value_nullness(enum bpf_map_type type);
+static bool can_elide_value_nullness(const struct bpf_map *map);
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
@@ -8621,7 +8621,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
 		if (err)
 			return err;
-		if (can_elide_value_nullness(meta->map.ptr->map_type)) {
+		if (can_elide_value_nullness(meta->map.ptr)) {
 			err = get_constant_map_key(env, reg, key_size, &meta->const_map_key);
 			if (err < 0) {
 				meta->const_map_key = -1;
@@ -10225,9 +10225,12 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
  * lookup return value nullness check. This is possible if the key
  * is statically known.
  */
-static bool can_elide_value_nullness(enum bpf_map_type type)
+static bool can_elide_value_nullness(const struct bpf_map *map)
 {
-	switch (type) {
+	if (map->map_flags & BPF_F_INNER_MAP)
+		return false;
+
+	switch (map->map_type) {
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 		return true;
@@ -10589,7 +10592,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 
 		if (func_id == BPF_FUNC_map_lookup_elem &&
-		    can_elide_value_nullness(meta.map.ptr->map_type) &&
+		    can_elide_value_nullness(meta.map.ptr) &&
 		    meta.const_map_key >= 0 &&
 		    meta.const_map_key < meta.map.ptr->max_entries)
 			ret_flag &= ~PTR_MAYBE_NULL;
-- 
2.34.1

