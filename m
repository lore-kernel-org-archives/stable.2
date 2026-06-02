Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398C2DC334
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371170; cv=none; b=QnLUy6cEiR2V9DMZncMccG3zbICTBxqecRSS84zq6Alyr6+lpVNe+nGAMeiEmvdzohQz+lTDvn5qMWq+xgUPxLsVmx0yx593ejaF5JJ4cX/G6vZQ36F7NuyRjgCIGJKN1ximjjwMecY7tW6G/YpwyVAJgdczmwVbWjObtJM1pcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371170; c=relaxed/simple;
	bh=xskOilzoIPU7L+dsZZo6KP+0yz2VLVqDiy6VfJmLJBA=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=p27UoLhetZxq4YETSfTR9kV8z+8Dj5sZHck0Jyahv/FVngS3fbfAKOhYU1JyzTgJYnsM/TMycoYdfIQL9qEYFRQMAb8FSQ7PHCS9kCb6x9lOAeT4njeJg1k7Cdvz1RU9oSgpKq62V9U+H5s8XvhV9uI0uWSzSgILkJltcQdUdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT9HRtGn; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT9HRtGn"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-915767ea2d0so70726885a.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 20:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780371166; x=1780975966; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j0CKbJj8QrYuhAIDLjRrGgebNjuXjxYKwkDAf/9N+ss=;
        b=TT9HRtGno8jZIReHFnBd7RYY2jyBo0ta49rW4qYmRrjmqUVwkLE0732VusQ8mdii0A
         cObTKYn23PCgJ5EYnS8ijKr9wNBV0EiLjH0+Ur6aIRUSQfIREB2nH8BiPNiq1bvLMVjy
         9JaVx+G/yPoSPFN8TFfhA6i+sDfzyCbq5pf0F4LRXXpMgCeTTwU9Jqa0SyH3gvOehDyR
         5WDhl2sqNQHRep6Ud8Z+0U5dhbCZgRzVIX6iifFJ2pTOwkT+Nf6GjeXI7RF0La0jKT4A
         y8kND4IJEwTQhCpVYWeLfNS8sDH3Y4iCnk1fyFOXhM1+kVKUwvppsBW/pjKQOMO43Zgy
         AUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780371166; x=1780975966;
        h=mime-version:content-transfer-encoding:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0CKbJj8QrYuhAIDLjRrGgebNjuXjxYKwkDAf/9N+ss=;
        b=V/rDbBAzlnr/4orQuzErAj3FnHiyix4ijGgADIEIiguoH3oQzzvAZHpFJoqgfHBgF4
         l47eY0vWKWl+423bCWvjmDy41ir2f6qlhE7RWBPn4ulHj75J5w3T/QhAyR9aASLEkdTL
         MpAGR3op1qux+drIk3U9g0p757Wvd1kqJpmJxifvDbkYDYlJqb29OHaDHgdo0EajAtLx
         7iMyqXgmzCpa/e0MxyalJ5Fc4dAnjt9kCoB6gTkU5b1Y4a46m4jGB/g4XmxPudnC1blu
         98/lyjSjwPk2SuyQjCelUCFwMvx+UMc4+K4wwU8jbw1v9UZsxqsUd9tWXgEUDFaaVtaC
         sLfg==
X-Forwarded-Encrypted: i=1; AFNElJ8kt3asz/DCbeUx+EDxsom5L+n/tyoJkAEMpRmXxX6xG75UUYiZkPu7AKaAHRBcQZ28qF8zAmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8tp4rec4abnInkoAGoPPXRCDGmY/C5DjHhSvHOynKh6k9nAFR
	hmQ92mpCC4tX2aopv86BX/nGyIfu9U05Vm/yMmWDU2hr/WXkgIWfNh/q
X-Gm-Gg: Acq92OFYHAN1alreS5Pq/6YIB4kA0OK61cmzG1Gfk8RZvYH9LfIU7ET8A+jZTvBSIWD
	WGmWe3T1OWTM9BAfbDC00zIhHeVcwaCjpwU0uRiL0IZyETN0gUmTV++ajqUOSRzM9kqaQ9D8VEa
	zprjsyvTVQqPffR4c7exMHcjxIRviGchGZQ20Fm6lotTUx5s3oz0RNrOf36yA1A1sqoi1U6v2jZ
	qc6htUKuS0URrKrteAlYrBvAo5iB6FX1W03xQRbDgwZgWZW1Jzhr5I0HyXIzH7w+4v47zz1HZzL
	Mxt4QIDQc9OzNnY56OeRgGpV5KWkDt/s7zSy677bGka5jUjbLfOL78zaVIOSDpFVm2MwW9A/et4
	ALcqjH4urp344xD8Nm9TW63d6pCQ4yw5VX81Xzv2pnlF/2rCX6BtBSt/U5ExAibWk7+GF8ApKqD
	Lp8/R/S7gDm8ta/TB/LHJeshj2ZzMYKW4fFITLsGPMX9OfIi/D8Lhs4uhW+E84wR7U2XiuONUxv
	CsIk+L2hs5UqAugxhwXW/74zlHsZPGMzITM0wQVCMnZkkeMHzE=
X-Received: by 2002:a05:6214:3482:b0:8cd:7c6a:8147 with SMTP id 6a1803df08f44-8cd7c6a8436mr158018216d6.10.1780371165867;
        Mon, 01 Jun 2026 20:32:45 -0700 (PDT)
Received: from srv1619992.hstgr.cloud (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042373sm110086696d6.9.2026.06.01.20.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:32:45 -0700 (PDT)
Message-ID: <6a1e4edd.541e6ed7.68248.dfe4@mx.google.com>
Date: Mon, 01 Jun 2026 20:32:45 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: security@kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I'm reporting an out-of-bounds read in `nvmet_auth_reply()`
(`drivers/nvme/target/fabrics-cmd-auth.c`), reachable from an
unauthenticated remote attacker against any nvmet host that has
DH-HMAC-CHAP authentication enabled on a configured subsystem.

The bug is present in **mainline torvalds/master** at audit time
(2026-06-02, verified via raw.githubusercontent.com fetch). It is
also present in stable LTS 6.6.x and other branches that ship the
NVMe-oF DH-HMAC-CHAP target (the function was added with the
DH-HMAC-CHAP target feature in 6.0).

CVSS 3.1 base: AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N =3D **7.5 (High)**.

This is filed shortly after my earlier report of an arbitrary
kernel-memory read in `nvmet_execute_disc_get_log_page` (sent today
to this list). Both are in `drivers/nvme/target/` and both are
attacker-controlled-length-meets-pointer-arithmetic class =E2=80=94 but they
are independent bugs with independent fixes.

=3D=3D Affected code (cited from torvalds/master, 2026-06-02) =3D=3D

`drivers/nvme/target/fabrics-cmd-auth.c::nvmet_execute_auth_send()`
(the AUTH_Send PDU dispatcher) does:

  tl =3D le32_to_cpu(req->cmd->auth_send.tl);  /* attacker u32 */
  if (!tl) { ... goto done; }
  if (!nvmet_check_transfer_len(req, tl)) return;
  d =3D kmalloc(tl, GFP_KERNEL);
  if (!d) { ... }
  status =3D nvmet_copy_from_sgl(req, 0, d, tl);
  /* ... dispatch by data->auth_id ... */
  if (data->auth_id =3D=3D NVME_AUTH_DHCHAP_MESSAGE_REPLY)
      dhchap_status =3D nvmet_auth_reply(req, d);

The ONLY validation of `tl` is "non-zero" and that the SGL transfer
length matches the command's declared length. There is no check that
`tl` is large enough to contain the struct header *plus* the
payload that the message body advertises.

`nvmet_auth_reply()` then does:

  struct nvmf_auth_dhchap_reply_data *data =3D d;
  u16 dhvlen =3D le16_to_cpu(data->dhvlen);
  u8 *response;

  if (dhvlen) {
      if (!ctrl->dh_tfm) ...
      if (nvmet_auth_ctrl_sesskey(req, data->rval + 2 * data->hl,  /* OOB#3 */
                                  dhvlen) < 0) ...
  }

  response =3D kmalloc(data->hl, GFP_KERNEL);
  ...
  if (nvmet_auth_host_hash(req, response, data->hl) < 0) ...
  if (memcmp(data->rval, response, data->hl))            /* OOB#1 */
      ...
  if (data->cvalid) {
      req->sq->dhchap_c2 =3D kmemdup(data->rval + data->hl, data->hl, /* OOB#=
2 */
                                   GFP_KERNEL);
      ...
  }

Three call sites use `data->hl` (an attacker-controlled u8, range
0-255 from the wire) and `data->dhvlen` (an attacker-controlled
__le16, range 0-65535) as offsets into / lengths reading from
`data->rval` without any prior check that the PDU transfer length
contained the corresponding bytes.

Supporting struct (`include/linux/nvme.h:1712`):

  struct nvmf_auth_dhchap_reply_data {
      __u8    auth_type;
      __u8    auth_id;
      __le16  rsvd1;
      __le16  t_id;
      __u8    hl;          /* attacker u8 */
      __u8    rsvd2;
      __u8    cvalid;
      __u8    rsvd3;
      __le16  dhvlen;      /* attacker __le16 */
      __le32  seqnum;
      /* 'hl' bytes of response data */
      __u8    rval[];
      /* followed by 'hl' bytes of Challenge value */
      /* followed by 'dhvlen' bytes of DH value */
  };

`sizeof(struct nvmf_auth_dhchap_reply_data)` =3D 16 bytes (header only).

=3D=3D Attack flow =3D=3D

1. Attacker opens TCP/4420 to a nvmet host that has DH-HMAC-CHAP
   configured on at least one subsystem.
2. Sends NVMe-TCP ICReq, receives ICResp (transport handshake).
3. Sends NVMe-Fabrics Connect with `subsysnqn =3D <target subsys with
   CHAP>`, any `hostnqn`. (Connect succeeds; the controller now
   expects the host to drive the CHAP exchange.)
4. Sends AUTH_Send with `auth_id =3D MESSAGE_NEGOTIATE`, advertising
   any supported hash (e.g., SHA-256).
5. AUTH_Receive =E2=80=94 controller sends CHALLENGE.
6. Sends a malicious AUTH_Send with:
     auth_type  =3D NVME_AUTH_DHCHAP_MESSAGES (1)
     auth_id    =3D NVME_AUTH_DHCHAP_MESSAGE_REPLY (2)
     tl         =3D 16 (sizeof(struct nvmf_auth_dhchap_reply_data) only;
                       no rval[] payload)
     data->hl   =3D 0xff
     data->cvalid =3D 1
     data->dhvlen =3D 0
7. Kernel:
     - kmalloc(16) returns a kmalloc-16 slab object (SLUB rounds up).
     - copy_from_sgl writes the 16-byte attacker header into it.
     - data =3D d; data->rval =3D d + 16 =3D past the allocation.
     - memcmp(data->rval, response, 255) reads 255 bytes starting at
       offset 16 of the kmalloc-16 slab object =E2=80=94 directly into the
       adjacent slab object.
     - If data->cvalid is set, kmemdup(data->rval + 255, 255) reads
       an additional 510 bytes past the allocation and copies 255 of
       them into a new kernel allocation (which the attacker can
       later exfil via further wire messages if the CHAP exchange
       continues, e.g., via AUTH_Receive's payload).

=3D=3D KASAN catch signature (expected) =3D=3D

Under KASAN this produces a slab-out-of-bounds READ report tied to
`memcmp` / `kmemdup` called from `nvmet_auth_reply`:

  BUG: KASAN: slab-out-of-bounds in memcmp+0x... (or __asan_memcmp)
  Read of size 255 at addr ffff... by task kworker/...
  Call Trace:
   memcmp
   nvmet_auth_reply
   nvmet_execute_auth_send
   nvmet_tcp_io_work
   ...

I've prepared an in-kernel proof module
(`nvmet-auth-oob-proof.c`) that replicates the primitive against a
deliberately-undersized buffer to make the KASAN signature explicit;
it's a one-shot module that builds against any current 6.x kernel
tree. Available on request =E2=80=94 withheld from this initial mail to keep
disclosure surface minimal.

A userspace network reproducer (Python NVMe-TCP client driving the
CHAP state machine through the malicious AUTH_Send) is in progress
and will follow.

=3D=3D Fix proposal =3D=3D

Validate the PDU transfer length covers the struct header *plus* the
hl- and dhvlen-derived payload before any pointer arithmetic on
data->rval. The minimal fix sits at the entry to nvmet_auth_reply:

  --- a/drivers/nvme/target/fabrics-cmd-auth.c
  +++ b/drivers/nvme/target/fabrics-cmd-auth.c
  @@ -112,6 +112,7 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void =
*d)
   {
           struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
           struct nvmf_auth_dhchap_reply_data *data =3D d;
  +        u32 tl =3D le32_to_cpu(req->cmd->auth_send.tl);
           u16 dhvlen =3D le16_to_cpu(data->dhvlen);
           u8 *response;

  @@ -119,6 +120,16 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void=
 *d)
                    __func__, ctrl->cntlid, req->sq->qid,
                    data->hl, data->cvalid, dhvlen);

  +        /* Confirm the transferred length actually contains the
  +         * rval payload the message body advertises. The host
  +         * response is hl bytes; with cvalid set, hl more bytes
  +         * of challenge follow; with dhvlen set, dhvlen more
  +         * bytes of DH value follow.
  +         */
  +        if (tl < sizeof(*data) + data->hl +
  +                 (data->cvalid ? data->hl : 0) + dhvlen)
  +                return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
  +
           if (dhvlen) {
                   if (!ctrl->dh_tfm)
                           return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;

The same shape applies to `nvmet_auth_negotiate` and any other
auth-state handler that reads variable-length fields from the
attacker buffer. A defence-in-depth alternative is to do this length
validation once inside `nvmet_execute_auth_send` before dispatching,
since the handler-specific math (hl, dhvlen, etc.) varies per
message type.

=3D=3D Affected branches =3D=3D

Confirmed vulnerable: mainline torvalds/master at 2026-06-02
(verified via raw.githubusercontent.com fetch).

Probable also vulnerable: linux-stable 6.6.x, 6.1.x (where the
DH-HMAC-CHAP target was backported), and distros tracking those
(Debian/Ubuntu/RHEL/SUSE).

NOT vulnerable: any kernel without `CONFIG_NVME_TARGET_AUTH=3Dy` (the
auth subsystem isn't compiled in).

=3D=3D Threat model =3D=3D

This is reachable pre-final-authentication: the attacker has
completed Fabrics Connect (which establishes the controller binding)
but has not yet completed the CHAP handshake. CHAP is exactly what
this code is supposed to enforce; the bug is in the CHAP enforcement
itself. The kernel cannot rely on CHAP being effective when the CHAP
handler can be tricked into reading past its input buffer before any
secret is verified.

Network reachability is "any host that can open TCP/4420 to the
nvmet target". In production NVMe-oF deployments this is the same
exposure surface that DH-HMAC-CHAP exists to protect =E2=80=94 i.e., the
mitigation is the bug.

=3D=3D Researcher / Credit =3D=3D

Jeremy Erazo (trexnegr0)
mendozayt13@gmail.com
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>

=3D=3D Disclosure preferences =3D=3D

I'm happy with any reasonable embargo length (14-30 days). I have
not shared this finding with any third party. Please coordinate CVE
assignment with the kernel.org CNA.

This is the second nvmet finding I'm reporting today; both are
independent bugs but they neighbour each other in the same subsystem
and one combined backport batch on the stable side might be the
cleanest disposition. Happy to coordinate that with whichever route
your team prefers.

Thanks for your time.

=E2=80=94 Jeremy
