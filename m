Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55439935D;
	Sun, 14 Jun 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781450892; cv=none; b=hmGfBIIdMw9qU0/KwSTmHXFDjQzwivbi0mSKv9VnG2bNUUQzQBuiOIX80u4Ldt48aOOuFrKbuMhMJyjz4PHOam/Fd6Da2aJ3b8Sh+Lo6lWWOhfVjCYIBEd7eDJFNRoAe6ImXjGPpEZi5doSo6fcE3QjHtHXSBfAP1Sq+GI4Jv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781450892; c=relaxed/simple;
	bh=RA6Ixt9t/D/Tq/FQzJslWZS1ccrzpLVjhsaW8rGl2i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1qWYmIVyIBlySBQ2VmeULercqE/HQJptuUI5ykCK76Pf49e3Ux4fnkM6EyUPo2wmo4S45s2YK5WtvXUrk+SeAJqMCKsJCSv3UZ1K7VbzRgtgjBFb8MBzWilc7ueBTeeTcRX2bbC50Zf+bPlWu3dSxSSP+9mtoTZLDl2G5IeGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=f0NrNKfg; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="f0NrNKfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=r0Vh6
	aD6Sxa0AeAPLHPlYZfHFLnQ0N+vngI60izVk8U=; b=f0NrNKfg7thbcZsrdyMK4
	gLP1J7fJb0MJnB3ibzqEQKHhVkfBq/mUTvLmL/2mqBLB/ZHbGMkpcyF4rRDAwGBg
	7OF0s4A0X6rIBlaaGg5aqwOsJ97SaZtSlZA5FFUZrz2DzHJNPwhKh0PLDXElKV6F
	VPgyyMz//2IJ+xcAbSjrJ0=
Received: from DESKTOP-35NLEVI (unknown [166.111.239.35])
	by web4 (Coremail) with SMTP id ywQGZQDHq5t1yC5qELxFAg--.40955S2;
	Sun, 14 Jun 2026 23:27:50 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] atm: br2684: reject short VC-MUX bridged frames
Date: Sun, 14 Jun 2026 23:27:45 +0800
Message-ID: <20260614152746.308-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:ywQGZQDHq5t1yC5qELxFAg--.40955S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw47XF1xtw1DXr17CF13CFg_yoW8AF15pa
	9rWFnakFZ5WrW7A34vy342vrW5CFs5tryfKry7Ka47Z3Z0gF18Xw1rKFZagr15C3yrGFyU
	AayI9FW7KF4DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjTa0DUU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgESAWoudiEQCwABsZ

br2684_push() validates the two-byte pad at the start of received=0D
VC-MUX bridged frames with memcmp(), but does not first make sure that=0D
those two bytes are present in the skb.=0D
=0D
A short AAL5 PDU can reach this path after a BR2684 VCC is attached with=0D
BR2684_ENCAPS_VC and bridged payload.  If skb->len is 0 or 1, the pad=0D
comparison reads beyond the valid skb data.  When the bytes beyond=0D
skb->len compare as zero, the code then continues toward eth_type_trans()=0D
with the malformed frame.=0D
=0D
Reject frames shorter than BR2684_PAD_LEN before checking the pad.  This=0D
keeps the existing validation for valid VC-MUX bridged frames, which must=0D
carry the two-byte pad before the Ethernet header.=0D
=0D
Fixes: 7e903c2ae36e ("atm: [br2864] fix routed vcmux support")=0D
Cc: stable@vger.kernel.org=0D
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>=0D
Reported-by: Ao Wang <wangao@seu.edu.cn>=0D
Reported-by: Xuewei Feng <fengxw06@126.com>=0D
Reported-by: Qi Li <qli01@tsinghua.edu.cn>=0D
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>=0D
Assisted-by: GLM:GLM-5.1=0D
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
---=0D
 net/atm/br2684.c | 2 ++=0D
 1 file changed, 2 insertions(+)=0D
=0D
diff --git a/net/atm/br2684.c b/net/atm/br2684.c=0D
index 6580d67c3456..07283c475a40 100644=0D
--- a/net/atm/br2684.c=0D
+++ b/net/atm/br2684.c=0D
@@ -491,6 +491,8 @@ static void br2684_push(struct atm_vcc *atmvcc, struct =
sk_buff *skb)=0D
 			skb->pkt_type =3D PACKET_HOST;=0D
 		} else { /* p_bridged */=0D
 			/* first 2 chars should be 0 */=0D
+			if (skb->len < BR2684_PAD_LEN)=0D
+				goto error;=0D
 			if (memcmp(skb->data, pad, BR2684_PAD_LEN) !=3D 0)=0D
 				goto error;=0D
 			skb_pull(skb, BR2684_PAD_LEN);=0D
=0D
-- =0D
2.43.0=0D

