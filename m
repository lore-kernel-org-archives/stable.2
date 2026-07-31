Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF63E8340;
	Fri, 31 Jul 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507723; cv=none; b=KeLz+vm+TubHVHl5erbcK9fK4YN7xCXIQRkVNXcFeOqtrsd/sG/WKRlzTNjWerPYtthEJuqzFsczlp96+OUkr7QEIClMFGog82c2wbSuv232t4jp3n9udvIjot6mm+oTlCXgqwvc8G1AtC+QHG75ZrFpscv/6Z2rVXnJBZu+vaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507723; c=relaxed/simple;
	bh=IE41Avm6A0BwSPXB9pDOV4zrpbgE82b+rIXiXD3VPug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jy2ce92Op9hg0hlo2jt9hX18BbZWbdVT7ObAxuEWpuCDD460FjO8VD9LgsRbdZ4nA/doRL7Y1zV7nC8CpbMW8WTqSDpuFqa0Ac+wCrsIfASGUzWegkhM0Oot+IQCWl7yAmOudWKnNQ58m/6i48Ih4fB442ZLieYPFlsGueQ7xsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowABXWzl+r2xqkzNKAg--.21969S2;
	Fri, 31 Jul 2026 22:21:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v3] powerpc/perf/hv-gpci: bound sysfs output with helpers
Date: Fri, 31 Jul 2026 22:21:50 +0800
Message-ID: <20260731141800.4-hv-gpci-v3-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXWzl+r2xqkzNKAg--.21969S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF18Jw4UZF1DJFy5JFWfAFb_yoW3CFWkpF
	4rKrW3Kw45Ww18WrW0ka1kZr1S9392y347J3yfK3sayrnrAwsFkFyIyFyjkry7CrWxCF18
	CrZ8tws8Ca17XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

systeminfo_gpci_request() and
affinity_domain_via_partition_result_parse() hex-encode hypervisor data
into the single-page sysfs read buffer with sprintf(buf + *n, ...).
Both helpers only check PAGE_SIZE after the formatting loops have
already advanced past the end of the buffer.

Add small helpers around sysfs_emit_at() for hex-byte and newline
appends, and stop once the sysfs buffer is full. This keeps the repeated
bounds handling local instead of open-coding it at each append site.

Return errors from systeminfo_gpci_request() through an int and update
all of its callers accordingly, so negative formatting errors are not
converted through an unsigned return type.

Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
Fixes: a15e0d6a6929 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via partition information")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2: https://lore.kernel.org/all/20260424070103.1-hv-gpci-v2-pengpeng@iscas.ac.cn/
- change systeminfo_gpci_request() to return int and update all callers,
  as requested by Madhavan Srinivasan
- keep the raw hypervisor return in a signed long before mapping it to the
  helper's documented return values
- rebase onto the current tree

 arch/powerpc/perf/hv-gpci.c | 113 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 7269273d3aa8..0bfd8061969a 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -130,11 +130,36 @@ static int sysinfo_counter_request[] = {
 
 static DEFINE_PER_CPU(char, hv_gpci_reqb[HGPCI_REQ_BUFFER_SIZE]) __aligned(sizeof(uint64_t));
 
-static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
-			u16 secondary_index, char *buf,
-			size_t *n, struct hv_gpci_request_buffer *arg)
+static int hv_gpci_emit_hex_byte(char *buf, size_t *n, u8 byte)
 {
-	unsigned long ret;
+	int len;
+
+	len = sysfs_emit_at(buf, *n, "%02x", byte);
+	if (len <= 0)
+		return -EFBIG;
+
+	*n += len;
+	return 0;
+}
+
+static int hv_gpci_emit_newline(char *buf, size_t *n)
+{
+	int len;
+
+	len = sysfs_emit_at(buf, *n, "\n");
+	if (len <= 0)
+		return -EFBIG;
+
+	*n += len;
+	return 0;
+}
+
+static int systeminfo_gpci_request(u32 req, u32 starting_index,
+				   u16 secondary_index, char *buf,
+				   size_t *n, struct hv_gpci_request_buffer *arg)
+{
+	long ret;
+	int rc;
 	size_t i, j;
 
 	arg->params.counter_request = cpu_to_be32(req);
@@ -177,9 +202,14 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 	for (i = 0; i < be16_to_cpu(arg->params.returned_values); i++) {
 		j = i * be16_to_cpu(arg->params.cv_element_size);
 
-		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[j]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++) {
+			rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[j]);
+			if (rc)
+				return rc;
+		}
+		rc = hv_gpci_emit_newline(buf, n);
+		if (rc)
+			return rc;
 	}
 
 	if (*n >= PAGE_SIZE) {
@@ -194,7 +224,7 @@ static ssize_t processor_bus_topology_show(struct device *dev, struct device_att
 				char *buf)
 {
 	struct hv_gpci_request_buffer *arg;
-	unsigned long ret;
+	int ret;
 	size_t n = 0;
 
 	arg = (void *)get_cpu_var(hv_gpci_reqb);
@@ -264,7 +294,7 @@ static ssize_t processor_config_show(struct device *dev, struct device_attribute
 					char *buf)
 {
 	struct hv_gpci_request_buffer *arg;
-	unsigned long ret;
+	int ret;
 	size_t n = 0;
 
 	arg = (void *)get_cpu_var(hv_gpci_reqb);
@@ -334,7 +364,7 @@ static ssize_t affinity_domain_via_virtual_processor_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct hv_gpci_request_buffer *arg;
-	unsigned long ret;
+	int ret;
 	size_t n = 0;
 
 	arg = (void *)get_cpu_var(hv_gpci_reqb);
@@ -406,7 +436,7 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
 						char *buf)
 {
 	struct hv_gpci_request_buffer *arg;
-	unsigned long ret;
+	int ret;
 	size_t n = 0;
 
 	arg = (void *)get_cpu_var(hv_gpci_reqb);
@@ -470,10 +500,12 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
 	return ret;
 }
 
-static void affinity_domain_via_partition_result_parse(int returned_values,
-			int element_size, char *buf, size_t *last_element,
-			size_t *n, struct hv_gpci_request_buffer *arg)
+static int affinity_domain_via_partition_result_parse(int returned_values,
+						      int element_size, char *buf,
+						      size_t *last_element, size_t *n,
+						      struct hv_gpci_request_buffer *arg)
 {
+	int rc;
 	size_t i = 0, j = 0;
 	size_t k, l, m;
 	uint16_t total_affinity_domain_ele, size_of_each_affinity_domain_ele;
@@ -492,27 +524,40 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
 	 */
 	while (i < returned_values) {
 		k = j;
-		for (; k < j + element_size; k++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; k < j + element_size; k++) {
+			rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[k]);
+			if (rc)
+				return rc;
+		}
+		rc = hv_gpci_emit_newline(buf, n);
+		if (rc)
+			return rc;
 
 		total_affinity_domain_ele = (u8)arg->bytes[k - 2] << 8 | (u8)arg->bytes[k - 3];
 		size_of_each_affinity_domain_ele = (u8)arg->bytes[k] << 8 | (u8)arg->bytes[k - 1];
 
 		for (l = 0; l < total_affinity_domain_ele; l++) {
 			for (m = 0; m < size_of_each_affinity_domain_ele; m++) {
-				*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
+				rc = hv_gpci_emit_hex_byte(buf, n, (u8)arg->bytes[k]);
+				if (rc)
+					return rc;
 				k++;
 			}
-			*n += sprintf(buf + *n,  "\n");
+			rc = hv_gpci_emit_newline(buf, n);
+			if (rc)
+				return rc;
 		}
 
-		*n += sprintf(buf + *n,  "\n");
+		rc = hv_gpci_emit_newline(buf, n);
+		if (rc)
+			return rc;
 		i++;
 		j = k;
 	}
 
 	*last_element = k;
+
+	return 0;
 }
 
 static ssize_t affinity_domain_via_partition_show(struct device *dev, struct device_attribute *attr,
@@ -523,6 +568,7 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
 	size_t n = 0;
 	size_t last_element = 0;
 	u32 starting_index;
+	int element_size, rc, returned_values;
 
 	arg = (void *)get_cpu_var(hv_gpci_reqb);
 	memset(arg, 0, HGPCI_REQ_BUFFER_SIZE);
@@ -555,10 +601,16 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
 	 * to buffer util we get all the information.
 	 */
 	while (ret == H_PARAMETER) {
-		affinity_domain_via_partition_result_parse(
-			be16_to_cpu(arg->params.returned_values) - 1,
-			be16_to_cpu(arg->params.cv_element_size), buf,
-			&last_element, &n, arg);
+		returned_values = be16_to_cpu(arg->params.returned_values);
+		element_size = be16_to_cpu(arg->params.cv_element_size);
+		rc = affinity_domain_via_partition_result_parse(returned_values - 1,
+								element_size, buf,
+								&last_element, &n,
+								arg);
+		if (rc) {
+			put_cpu_var(hv_gpci_reqb);
+			return rc;
+		}
 
 		if (n >= PAGE_SIZE) {
 			put_cpu_var(hv_gpci_reqb);
@@ -587,10 +639,15 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
 	}
 
 parse_result:
-	affinity_domain_via_partition_result_parse(
-		be16_to_cpu(arg->params.returned_values),
-		be16_to_cpu(arg->params.cv_element_size),
-		buf, &last_element, &n, arg);
+	returned_values = be16_to_cpu(arg->params.returned_values);
+	element_size = be16_to_cpu(arg->params.cv_element_size);
+	rc = affinity_domain_via_partition_result_parse(returned_values,
+							element_size, buf,
+							&last_element, &n, arg);
+	if (rc) {
+		put_cpu_var(hv_gpci_reqb);
+		return rc;
+	}
 
 	put_cpu_var(hv_gpci_reqb);
 	return n;
-- 
2.50.1

