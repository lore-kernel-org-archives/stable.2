Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638F3A2549;
	Sun,  7 Jun 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780834769; cv=none; b=vDF8Aa67xpr8SquFw53IHeEty4cmUj4xr8bl251XWYvIeuot2+oa77bt7r/IzSBVPJOgpakGPhoJzwvjCtz+l0RFQGwpUj40W+o8Pzgy7mRle4/kI8HoCchzWuJSM0N5N6r4fLs3CvLlcRQ2DdfJDWFOS/s+jCBWP9FsURVIPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780834769; c=relaxed/simple;
	bh=zhsBBz8rvMp0MDvManYHUPyFESBBsTkM4xyF9UE4LsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phQctZhDJnXSqCKSuULIViimWARENbi+p/Liy+gWw+cjY4Hqkf9gO6Q90doKn3MaKLncHIpJp+jsu2PQnlhGvrKUGF40gF8d90lfWZJjyLPnne3adzDxQU7unry+qOl3YMllaQJe7oJBfaoJgqJqXTTuruLh2foOf4HoX9M8E4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ThF9Czbh; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ThF9Czbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=6BNCs
	I3At/XfYeZzgEFPg8k5Uh83Vh5DEtj4ugHkCMQ=; b=ThF9Czbhqg73eBM9Xl4Z6
	zae4nMNVAYsWwW+gEi5FgKrbGxB7YcN/+l+EaTiP/GAJfN9TAKW30gD+zk4TTdsL
	pxUmEI2o6qc6UBH8r3FkNqAYzR+HbprY4cLzcr56BZD0W9yfq8cIr+ZIOdmsWBr9
	0JOxMBvs7FCRaDdz/eF9UQ=
Received: from localhost.localdomain (unknown [101.5.11.216])
	by web3 (Coremail) with SMTP id ygQGZQBXpZLBYSVqmYI4Ag--.64208S2;
	Sun, 07 Jun 2026 20:19:13 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: v9fs@lists.linux.dev
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net/9p/usbg: fix prefix matching in device lookup
Date: Sun,  7 Jun 2026 20:19:04 +0800
Message-ID: <20260607121907.12588-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBXpZLBYSVqmYI4Ag--.64208S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUWr43Aw15AFyxCw1fXrb_yoW8Ar4rpa
	y7uF9IkFyUJry3Za97tan7CrW7Gan5GrW8try0qa43uwn0g3W8Jr40kw4SyrZ8Z39Fkr15
	tFWqqryjyF4Du3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xr1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0FksPUUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgILAWoknpuEQgAAsH

p9_usbg_create() matches the mount source against registered usb9pfs
instance tags with strncmp() and the length of the caller supplied source.
That accepts any prefix of the registered tag.

For example, a gadget instance tagged "secret_channel" can be selected with
"s", "sec", or any other non-empty prefix.  Once selected, the instance is
marked in use and the client is attached to that transport.  This differs
from the configfs tag lookup path, which uses strcmp() and therefore
requires an exact tag match.

Require an exact tag match in p9_usbg_create() as well.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/9p/trans_usbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 1ce70338999c..8c66795f2853 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -391,7 +391,7 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 	guard(mutex)(&usb9pfs_lock);
 
 	list_for_each_entry(dev, &usbg_instance_list, usb9pfs_instance) {
-		if (!strncmp(devname, dev->tag, strlen(devname))) {
+		if (!strcmp(devname, dev->tag)) {
 			if (!dev->inuse) {
 				dev->inuse = true;
 				found = 1;
-- 
2.43.0

