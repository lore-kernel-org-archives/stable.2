Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425302;
	b=dvpScxG8tzX1VIDGTb/HQH25wM4RE9iltJ0cH7xBsH/+3z7LjIUQRtLkFpwThIOdqFhJ
	 1mZHed18CtJDcxae6zpqVl6AgZ2tlJoLq3zzmAnKYnMXN2hD6IJB8jEzue9kD6rf7rgG5
	 AEPaKGRlxjy5tm9Z7iq2lh4xuo8icmk5bilGOLsmyqNbrp4bt2EWN/ozn9XyTM5dE99uK
	 zzrYnDUtWGpgKJHYfYU1a3Jx0T+hTmMszXMcvdIrfAunkNHUNMnc7l3Rvz3bXBbgaAK0x
	 AFZHpH1HiSIBOYQLHjlqAVfmgRfZ3IjsMacXFeSIED0a2YZxf/VwgcCd0oGrAG/OJDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425302;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=ZisvlS1kTTG8Fb44GuSnLxmZpmeW2Zqc0dqkPhQB0DE=;
	b=YMlp5FiyUJq+zC061mXPU5BiemZopg1XXpxTJydlTCdYa9TMPFsa0U2pCEVtwoijt9if
	 V91/k9IICgCa23sD1qeNvplhqUTG2kVhLv9rrxINMWkVatxB3mle5ro+fJmujJqriD9lC
	 Btfz4mVzB4+owvHgyWNuvgJT5pWrPSuOjkPiKulxWq+m+Lys3E0OOkqpNJL5C94mddCNc
	 gLILGlIo1iM5yLWYURszrIcwjcO1sUcuyCeWdZALSynj6wa+cO/DOc3UA8JZaGUqCiar1
	 BtC0XPGVxejAbU6W7LJR8Xt1MGzBL8F7Z149sT30pR8SMjvkJkp+Uxj4+/E0aUrWkmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SowECDfc;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E6606DA7A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 15:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A45E6606DA7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SowECDfc
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DAB51C63446;
	Mon, 19 Oct 2026 15:55:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B939F60582;
	Mon, 19 Oct 2026 15:54:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A434C10328C5E;
	Mon, 19 Oct 2026 17:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792425296; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZisvlS1kTTG8Fb44GuSnLxmZpmeW2Zqc0dqkPhQB0DE=;
	b=SowECDfcorebBDnBnlnPLuEg/tWRIWA481EeBhsJruSVvhNyBXjmqKWJKawwVdNGIlxv+j
	1FbVDv2JbVWsMRMLm7OOK+K2gbgcPB8+nPKZJkgW/mCQS9p00B0OeC05XozCHS+H1ldTQZ
	06H2WTEuBSsI5O3Cf8eOjS/9hHHiCYeCRmdZ709OdH1Q1EmuK+N6fSkEE3O46tPgZr82m2
	B2VAAHKezeVFG7KXQd8w8FGXjufHDnK+kDmKvCcc8/LeXWmetEtdystqWIhfo0DpbenfYG
	sLvSc4LwLH+T6+eVyYvtE2biyLOsSEn5IEguIMMLoEKlJMEr2K4EiDoYDNeUqw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 19 Oct 2026 17:54:52 +0200
Subject: [PATCH 5.10.y] bpf: Do mark_chain_precision for
 ARG_CONST_ALLOC_SIZE_OR_ZERO
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-cve-2022-49961-v1-1-ed1f29472e68@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3ZJtwJaX4V40O2q6wFNK0RDe
 HerHL9J5p+RNZlmHKoZSSfL9hgKeFNBbqfhqmSxGN75jh0HkkmpwFMTQscUGx9F9jt124hyeia
 92Psf7NHW7OoPjuuex/Nd5fWrYVm+dm4GRnoAAAA=
X-Change-ID: 20261019-cve-2022-49961-d42dcc87e03d
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Johnny Hao <johnny_haocn@sina.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792425293; l=4246;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=ZwAokZiIri1rVpj+EiVx+FYz4h1qG/NGrLHPqJf01Nc=;
 b=RyqUg7TruOX6QAsSEN9fmrliL5G80UHkNsFjAUPtYPgQYTRc9di0wkJ468/JzUUa4nA97V1v6
 /mmSuwYDFP/AuIfSMMMBd5sCRvgzPqfeSZ2oHyGCj8Qv+uRigp+cGk6
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 2fc31465c5373b5ca4edf2e5238558cb62902311 ]

Precision markers need to be propagated whenever we have an ARG_CONST_*
style argument, as the verifier cannot consider imprecise scalars to be
equivalent for the purposes of states_equal check when such arguments
refine the return value (in this case, set mem_size for PTR_TO_MEM). The
resultant mem_size for the R0 is derived from the constant value, and if
the verifier incorrectly prunes states considering them equivalent where
such arguments exist (by seeing that both registers have reg->precise as
false in regsafe), we can end up with invalid programs passing the
verifier which can do access beyond what should have been the correct
mem_size in that explored state.

To show a concrete example of the problem:

0000000000000000 <prog>:
       0:       r2 = *(u32 *)(r1 + 80)
       1:       r1 = *(u32 *)(r1 + 76)
       2:       r3 = r1
       3:       r3 += 4
       4:       if r3 > r2 goto +18 <LBB5_5>
       5:       w2 = 0
       6:       *(u32 *)(r1 + 0) = r2
       7:       r1 = *(u32 *)(r1 + 0)
       8:       r2 = 1
       9:       if w1 == 0 goto +1 <LBB5_3>
      10:       r2 = -1

0000000000000058 <LBB5_3>:
      11:       r1 = 0 ll
      13:       r3 = 0
      14:       call bpf_ringbuf_reserve
      15:       if r0 == 0 goto +7 <LBB5_5>
      16:       r1 = r0
      17:       r1 += 16777215
      18:       w2 = 0
      19:       *(u8 *)(r1 + 0) = r2
      20:       r1 = r0
      21:       r2 = 0
      22:       call bpf_ringbuf_submit

00000000000000b8 <LBB5_5>:
      23:       w0 = 0
      24:       exit

For the first case, the single line execution's exploration will prune
the search at insn 14 for the branch insn 9's second leg as it will be
verified first using r2 = -1 (UINT_MAX), while as w1 at insn 9 will
always be 0 so at runtime we don't get error for being greater than
UINT_MAX/4 from bpf_ringbuf_reserve. The verifier during regsafe just
sees reg->precise as false for both r2 registers in both states, hence
considers them equal for purposes of states_equal.

If we propagated precise markers using the backtracking support, we
would use the precise marking to then ensure that old r2 (UINT_MAX) was
within the new r2 (1) and this would never be true, so the verification
would rightfully fail.

The end result is that the out of bounds access at instruction 19 would
be permitted without this fix.

Note that reg->precise is always set to true when user does not have
CAP_BPF (or when subprog count is greater than 1 (i.e. use of any static
or global functions)), hence this is only a problem when precision marks
need to be explicitly propagated (i.e. privileged users with CAP_BPF).

A simplified test case has been included in the next patch to prevent
future regressions.

[ The context change is due to the commit 8ab4cdcf03d0
("bpf: Tidy up verifier check_func_arg()") in v6.0
which is irrelevant to the logic of this patch. ]

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20220823185300.406-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e1f571219d16..50bcf15eaa17 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4896,6 +4896,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->mem_size = reg->var_off.value;
+		err = mark_chain_precision(env, regno);
+		if (err)
+			return err;
 	} else if (arg_type_is_int_ptr(arg_type)) {
 		int size = int_ptr_type_to_size(arg_type);
 

---
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261019-cve-2022-49961-d42dcc87e03d

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

