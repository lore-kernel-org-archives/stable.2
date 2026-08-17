Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560213ADBA5
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987963; cv=pass; b=a/u1Gt38ONWLpX9CyT+ncyYIk3d9WXzLs0rQg8CJ1/yrd7C9kFuC3ldvTYRf2lOhFL+Y1sbGHNz4Nkv7VmXTw8a+XPkI2dd+8Rkh+I6HgIe3w8lbLdMNdgVi7URL5oKbBwtozAYjYfjER4hL9DoIwo4l/yQ43WfyI2rXOEb9ym8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987963; c=relaxed/simple;
	bh=UGXt1v8lzYIy5RWZxaevNP38Y360efpQ8u/2dkmbf6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzI00XlnK79C6jB8f6+TcSMsDDC/mQPkz2fgOZDU713L6t/ZHMF87BeUWD/zJznq50AARJLFyC20wruanQ0neGrLOJqOCR10SMGGMi+p6SLMX48MWRaKpOkANtkzaCbG4BA8Cc4p5Vf249VL+J0en8WA/MTmogozR925HuaNpBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDNetXjZ; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDNetXjZ"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66bd7857841so2714643d50.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786987959; cv=none;
        d=google.com; s=arc-20260327;
        b=H/ugmWnQSwQboU3cR8YXu+T/m9HdG4c8x/aQKLQ4lsp7fgHsnyosM7VZD+bBrFh12L
         NHqNCZ3EkKzb0tw5wV4hnOATDlk+ekZU+ZLlAXr2PD5neCSQ14QawWG2eB+OLvgO+Nbm
         2lRgrtiMmA6JduzMNw37fmil7e5XVLHIc6qor5D0bu+EImRZZed7WIILTAcjHDzjVogy
         rdJIWCxryxvBN44722jO41g68RtPrny377UadoFLI7+O0mUTmJM6BHcIhAdN9qpaRcF3
         H2+mrCRKhPIaeMZdLCRZLg17KFiaWx+t3F22fIgd0/a6S++FoZlvm7NtXP/n+k68Lua8
         4INg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O6NtOPuz7YXxI3CgzCU8k5jQwLkc89zpCvRdKJof0hU=;
        fh=oxL7XMIjtKduCn8RcbN9vnW4Gjf6VKgeAIPmLsUccgU=;
        b=pjmWmJVkyDwPRuMQ5Yls1h/hVIxsTvzpqybD8jQHTD0i0EL5ITTeKdDm+NsrpjrpqQ
         vOiVVw8r4oXKDJHF4o/O72vD20l1GrgT9hd8Eg+DD6u2CZIhilyZMjJ18WJ5gZ+yxVC9
         9bhdgqo5cCfvdjY3oTh5AFxzjFq+RViKsGhWcqNErMhxgEGkCe1hL5NW544imSIcR1zT
         +B8vN0IyOQLgA7N2rYXtH3/JP9qyMfMbqTyuC8y4ffc4nx/YtL6rdHlqUQzxVsjQqjF9
         zLcEfOidkNqYK/7Gxj0E9tw5BJnFIYfX1eBn56V5dpUY0QorZqQvnvc4BmtqOFbi0atL
         xpzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786987959; x=1787592759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O6NtOPuz7YXxI3CgzCU8k5jQwLkc89zpCvRdKJof0hU=;
        b=UDNetXjZb9Fd/vySSD8ViJ2neIQqVKsB0pf7udmiLFhfESQ8vaAn+OuWHOP+IVRtQN
         UEP2o5SvzoEkDFltBdDld8XRG3tvlRX38aodDR7KMWkFdZEUP5wQ6SVmCb8pSZZxf9ua
         NxqfpQ9xaLPzu0XV0aoZkGPoXw1Xdc3OGHbORHGcz4ZiXNY6U5yth5lGQ7PHJrzWupkO
         IElADA7BQf4kAU+lKSFCteeFgc9U4VukE1YmYlTv9PJj7rhvYGJxof04VEsEn4MvDCqg
         RfSIB03xHYBYlKavz30g0ljW9Awy/4SWpfbVBrGqC/GjRGOSh4pnFtyNOgKm8KB8X30/
         bC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987959; x=1787592759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6NtOPuz7YXxI3CgzCU8k5jQwLkc89zpCvRdKJof0hU=;
        b=X9NVaqfnAtiPY+KipjWesmtWTLDg9jC7zEqNYcV3JN+4YSkMAR6qECo5RYqZ8oMDys
         QUsPcRa8Hd0dqaXqEiR63GgszYkBPuE2k/alpOQ5IZUQmbmzh5JS8B5iJuZJoexsnPLy
         wZgpwvo0L7MUz/PGfO2DpiIIkchWW1jbkWMOVbZ9nz95bQlo1JPd89j+zCd6bJGA+9el
         wvkvuzWEDdjVtNXwcc5GYUuh82qDpUCiGxttwG5Kgze6fYde6o6Dh6mpyhFXM3ECRNPk
         gf7GTAttXATSsDdJPpCn4HZFmHRdv3MQ/fyAp5NOgt1dYwmqZYIYN9ryyXbJocYw8R23
         J67g==
X-Forwarded-Encrypted: i=1; AHgh+RqiTlqRB2mlJz/Zhar7rLBIuWX3wBt114QZllbwWB+r/yHNnOf7pWYhX4bSaA1892ZdNZIwQdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfoA3EUWAvPewE9n6D8coLOCctZUonwteTWuXi9FbJu2302MD
	UZNmLl+fn/f1G9YXQZq1Qv291sKiHUIPvfLkeRXWa/Ot+KXUgxZUCWhVv/7VTrVbhImkUZ+99fc
	nlGHzaUXg8KSKf24vKTXPFC/SPEhTXSE=
X-Gm-Gg: AR+sD10kmLuLXHMSxgs4XlFH/OuF0hLejdB0WjXNQUCMmY3vLvMqys/+EHYuPqlKpSp
	HJDAn6wCoSJL3EDV+6x+29wcDzjJnkG2sZ/tNWi1lciu7+WlT6CB8v+Sj4EPgi1kTj3Xy8rjfGX
	YSvuvwbHWAkUYJF4eyM/NSkLbshl0toOo7TCFIXZUlFkX4Hiky89a6/PDTLKN1EiKDLIzmrqwTQ
	mCfsvLyMb1sKHP+HiJzdENnKittq92/6O6Y+PGibEElcOiB2Sxj+ZdkGFs81ymcwDcGzJKgSN1Y
	go/5FpkVENf4N5JyFfjHFd0aR6DiT9KEOftGMcoi3Im3DYBFuy/Ung58367xO4i1ckxi7iLnsUE
	BCMmelPxTPEL3/z/0i5mDLo4vAAREXS8=
X-Received: by 2002:a53:ee50:0:b0:667:8f12:c48 with SMTP id
 956f58d0204a3-66c72cc4ba1mr6644503d50.26.1786987959233; Mon, 17 Aug 2026
 10:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814231248.3096377-1-tristmd@gmail.com>
In-Reply-To: <20260814231248.3096377-1-tristmd@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 13:32:27 -0400
X-Gm-Features: AcwNN1X0vZKR87eRnLXX9W9oXASCIrnh3TRfwnQscaGmWvciEcy9UpEb8C34WZc
Message-ID: <CABBYNZ+7UbQcO40RGEQNtfptWTf_BhnSmwounR-dOFZpmU=E7g@mail.gmail.com>
Subject: Re: [PATCH bluetooth] Bluetooth: cancel devcoredump work during
 device teardown
To: Tristan Madani <tristmd@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Manish Mandlik <mmandlik@google.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tristan,

On Fri, Aug 14, 2026 at 7:12=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> hci_devcd_setup() initializes dump_timeout and dump_rx work items
> during device allocation, but hci_unregister_dev() does not cancel
> them before the device is freed. If a devcoredump is in progress
> when the device is unregistered, the dump_timeout delayed work timer
> remains active. When it fires after hci_release_dev() frees the
> hci_dev struct, it accesses freed memory.
>
> Add hci_devcd_destroy() to disable dump work items and purge the
> dump queue, called from hci_unregister_dev() alongside the existing
> disable_work_sync() calls.
>
> Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  include/net/bluetooth/hci_core.h | 9 +++++++++
>  net/bluetooth/hci_core.c         | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 3df59849dcbea..5a60c3f94a462 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1800,6 +1800,15 @@ static inline void hci_devcd_setup(struct hci_dev =
*hdev)
>  #endif
>  }
>
> +static inline void hci_devcd_destroy(struct hci_dev *hdev)
> +{
> +#ifdef CONFIG_DEV_COREDUMP
> +       disable_delayed_work_sync(&hdev->dump.dump_timeout);
> +       disable_work_sync(&hdev->dump.dump_rx);
> +       skb_queue_purge(&hdev->dump.dump_q);
> +#endif
> +}
> +
>  int hci_dev_open(__u16 dev);
>  int hci_dev_close(__u16 dev);
>  int hci_dev_do_close(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5ba9fe8261ec8..d4d559dabf422 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2671,6 +2671,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         disable_delayed_work_sync(&hdev->cmd_timer);
>         disable_delayed_work_sync(&hdev->ncmd_timer);
>
> +       hci_devcd_destroy(hdev);
> +
>         hci_cmd_sync_clear(hdev);
>
>         hci_unregister_suspend_notifier(hdev);
> --
> 2.47.3

Sashiko found 2 issues, both seem valid to me:

https://sashiko.dev/#/patchset/20260814182849.940976-1-ali%40iusegentoo.com

--=20
Luiz Augusto von Dentz
