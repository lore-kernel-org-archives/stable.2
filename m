Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1A2264A9
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371161; cv=none; b=fZDm6Nbkq5D1C0ib2MrM8jH8iL8Dt0PsLqZs5oS20Pv5LSdQyQ+XyCdEuxU0YsiY9RGcwkMvDKKuxOEad9YR3Rma2TpMbj7FZGKjgU5qlk7VDpWaV92u+9isA29afk4UCCzEW9LfgELsMhHlzc5xwlClfDJej9QfiL8gLDW4Ijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371161; c=relaxed/simple;
	bh=xskOilzoIPU7L+dsZZo6KP+0yz2VLVqDiy6VfJmLJBA=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=qYwrplVjfI8gNbmPVKWTx9PtpLKNTPHnwlbXx+KnbzoLQWG7O6zBeNhcfmrIXa4FirWMyQE9UeS9GVsmeQ3HlaQND2yQ7K+u40DhGbvao+/MiMp/l6naQFQFUAbpWUh9UVLgvxMkRotpdVSGdo2u6KDEAxOK1mYKX5aFuvCge8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwTomY3H; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwTomY3H"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91550dda53cso318139285a.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780371158; x=1780975958; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j0CKbJj8QrYuhAIDLjRrGgebNjuXjxYKwkDAf/9N+ss=;
        b=RwTomY3H9YgfNXzyExzgvA1D3+28/EYNEUfjeb7f3xIdbcGMKIWO6t15Hn1DXidY1s
         Abe+BHVdZOWzj0uEeTMtRZF+9sWn70u5YMBYg0kaIqk2mraEGn/ETURV8+CorxUAReIp
         554iv82xX9qRy+e+Tm+kcUeMHcaaoZow6D6qlmewpaRJ8NZeFNKNG3ngpWPJeYqcXNE0
         YUyg6M8ulWdBJuhI6ssSxYG1O543xX86x58ZYa4dmrE5uz90JK7EHq3weEa67wDxJXS6
         xWck97DzQW83saZ6AVQHfUhHvj4OBT0CqTzxedfJdWGK1QMg+yEl9AJdQClVgX/7mTbL
         MdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780371158; x=1780975958;
        h=mime-version:content-transfer-encoding:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0CKbJj8QrYuhAIDLjRrGgebNjuXjxYKwkDAf/9N+ss=;
        b=IPOCXIe5l+hnZEZ8iVb41CASeduv/tTC4wixgKmmbx8KVUHtGbY68wwqT1J4cff5+y
         OUmUJSLlfc5do2ARE8zkDiYcgAbyFFvkZ7/b1wr/cmhWFMzEhrWlUHHsZkQAl+5yCdbX
         Ik58DZK2KrXtDoADjIZJIC1Izf1h9bSIuIP2OJaBAMMhhdCDorfZDTc5O0Rqqp5aXtbj
         8iud8ocWqcrxoM2EMqgOEKfrsmWlxOwr6DqdKv7AUVPWncEQBxrfqO4oYGAavnmcwFXE
         8XHQAM0HaCWDCIHLR8Y2n+c7O4zSyLAtV0dIIq7CyZ/rENb++yqwxSd0SW05Hv5+eDZ0
         mHAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZzgqpzJYBh/3NQ0y743D/SDXWfOM8A8ZngH+zXiTEsX7j4jORg6b88cknZCaTHymBuJs74lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLwDrmPNBxRzkahyAXyaq5co/MBbrFVcjwfAsCIXM5j8Ho/Vh
	0N4mk0m6CRxByB7WMwxb3fuwHN3RdftkO6Z4jawXW5QgHqP2y/TrRSIq
X-Gm-Gg: Acq92OEjFk+H9nS/yJpTfyriPvMHGJWStszwQ/ab+dzjVtNOKBUSFbPTNHLT4wOhX7W
	vSw5hp4T/8AUA/6CvGLUdK2vES/4aKlA67JLTcbYcmz35wjxVp7vnaOkiy0i8n74Tt/8MZ5pWYH
	T/WOR9n9eJbKVMZQSqeMwMdlBInW9M2ZF63XxLrLW+85tAwOe8cjcBqFxLt6LnvfmL8OQtmdXzA
	n1TZvlDoGXe4+57MNDP2xKFqcG8zCNs1cOnO3PBdGCUahlMlHtZpz5zNr9M3pJEJ25zmkhtIEff
	burWuzkC0JFEnXzNMiEGdmCpPGiwphD2LRhb+TN6ZYBx6ESufFl4eWx8mN2Crx/C0MntHJ2RUaX
	E6O81mWhatQQtYlTeTW5ZJ7LZZS85oqXGp+bCVZaYEpwHJhI41thdXkX2SuOzpqphjFUGMC7GPG
	PeOqX0m2K17XBQ8oAZtPUbp2vaZpNjU8xQrEG/hQbW2lrT7Osxxu4gUBzqPA5BUqrBUr9lHqqOL
	0kaWfuOj+pAmhryVq5tgTBEFcTR3rnqoeRYcUvhbhIjHMDIWjQ=
X-Received: by 2002:a05:620a:4890:b0:8bb:ac44:bd3c with SMTP id af79cd13be357-9153dc537c0mr2138437385a.52.1780371157659;
        Mon, 01 Jun 2026 20:32:37 -0700 (PDT)
Received: from srv1619992.hstgr.cloud (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153265d7f2sm1149456585a.43.2026.06.01.20.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:32:37 -0700 (PDT)
Message-ID: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
Date: Mon, 01 Jun 2026 20:32:37 -0700 (PDT)
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
